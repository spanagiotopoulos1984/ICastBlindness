class_name Goblin
extends AnimatedEntity

# Keep all the enums in a specific script, so I can accesss them from everywhere
# else.
const ENUM = preload("res://scripts/Enum.gd")
const DIRECTION = ENUM.Direction
const CASTABLE = ENUM.CASTABLE_SPELL

# Keeps the last direction when states change, so we can have smoother 
# animation transitions for static animations (like idle or casting)
@export var last_direction: DIRECTION =  DIRECTION.DOWN

# A variable to check if the goblin is in shadows or not.
@export var is_in_shadows : bool = false

# A variable to check if the goblin is inside a box or not.
@export var is_boxed : bool = false

@export var spell_to_cast: CASTABLE = CASTABLE.NONE

# The following vavriables are used by the state machine, so we can change
# easily between states, and interact diferently based on the current node
# state.
@onready var state_machine:GoblinStateMachine = $GolbinStateMachine

# Used to play with the sprite and the animations on x-axis.
@onready var sprite:Sprite2D = $Sprite2D

@onready var wand_marker: Marker2D = $Wand

@onready var interaction_ui: CanvasLayer = $InteractionUI

@onready var inventory_ui: CanvasLayer = $InventoryUI

# Ready is called when the node is initialized. The _ in this case means it is
# a pre-built class.
func _ready() -> void:
	state_machine.init(self)
	# Set this goblin reference to the Global script
	Global.set_golbin_reference(self)

# Used when an input is not consumed by a handler, so it can be propagated to
# the state machine.
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta) -> void:
	state_machine.process_physics(delta)
	

# A signal that is emitted every 2 seconds. It creates a trail of markers,
# that can be used to allow enemies to follow the player, while still allowing
# easy control of player states such as hiding inside the box or being in a 
# shadow area.
func _on_marker_creation_timer_timeout() -> void:
	var goblin_state_machine = state_machine as GoblinStateMachine
	goblin_state_machine.create_trail()


func _on_area_2d_area_entered(area) -> void:
	if area.get_parent().name == "ShadowAreas":
		is_in_shadows = true


func _on_area_2d_area_exited(area) -> void:
	if area.get_parent().name == "ShadowAreas":
		is_in_shadows = false

# Since I repeat this many times, it's not a bad idea to make a function here.
# Open or Close the Inventory, Pause or Unpause the games respectively
func enter_or_exit_inventory_screen() -> void:
	inventory_ui.visible = !inventory_ui.visible
	#get_tree().paused = !get_tree().paused
		
