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
var is_in_shadows : bool = false

# A variable to check if the goblin is inside a box or not.
var is_boxed : bool = false

# A variable to check if the goblin is inside a box or not.
var is_near_box: bool = false

# A variable to see is we are within range to dispell
var in_sign_dispell_range = false

# Keep the nearest box here
var nearest_box: Node2D = null

var spell_to_cast: CASTABLE = CASTABLE.NONE

# The following vavriables are used by the state machine, so we can change
# easily between stblindness_spellates, and interact diferently based on the current node
# state.
@onready var state_machine:GoblinStateMachine = $GolbinStateMachine

# Used to play with the sprite and the animations on x-axis.
@onready var sprite:Sprite2D = $Sprite2D

@onready var wand_marker: Marker2D = $Wand

@onready var interaction_ui: CanvasLayer = $InteractionUI

@onready var speech_label: Label = $Speech

@onready var spellbook = $SpellBook/ColorRect2/SpellContainer

@onready var trashed_box = preload("res://scenes/trashed_box.tscn")

var nearest_door: Area2D

var is_near_a_locked_door: bool  = false

@onready var speech_timer = $SpeechTimer


# Ready is called when the node is initialized. The _ in this case means it is
# a pre-built class.
func _ready() -> void:
	# Connet the SceneManager, so we can control player spawn between
	# areas
	SceneManager.on_player_spawn.connect(_on_spawn)
	state_machine.init(self)
	# Set this goblin reference to the Global script
	Global.set_golbin_reference(self)
	
	# Make speech text invisible and initialize it as empty.
	speech_label.text=""
	speech_label.visible=false

func _on_spawn(position: Vector2, direction:String):
	global_position = position
	animationPlayer.play("NORMAL_WALK_"+direction)
	animationPlayer.stop()

# Used when an input is not consumed by a handler, so it can be propagated to
# the state machine.
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta) -> void:
	state_machine.process_physics(delta)

func speak(text:String, delay:float) -> void:
	speech_label.text=text
	speech_label.visible=true	

	speech_timer.start()
	await speech_timer.timeout
	
	speech_label.text=""
	speech_label.visible=false

# A signal that is emitted every 2 seconds. It creates a trail of markers,
# that can be used to allow enemies to follow the player, while still allowing
# easy control of player states such as hiding inside the box or being in a 
# shadow area.
func _on_marker_creation_timer_timeout() -> void:
	var goblin_state_machine = state_machine as GoblinStateMachine
	goblin_state_machine.create_trail()

func _on_area_2d_area_entered(area) -> void:
	print(area.name,' of ',area.get_parent().name)
	if area.get_parent().name == "ShadowAreas":
		# Do not spam this all the time. 20% of times is okay I think
		if Global.get_percentage() > 0.9:
			speak('He he he he', 1.0)
		is_in_shadows = true
	elif area.get_parent().name == "Gnome" and not (is_in_shadows or is_boxed):
		speak('Gnome chasing me!', 1.0)
	elif area.get_parent().name == "Gnome" and (is_in_shadows or is_boxed):
		speak('Gnome can\'t see me here!', 1.0)
	elif area.is_in_group('Box'):
		is_near_box=true
		nearest_box = area.get_parent()
	elif area.name == 'VPDInteractionArea':
		in_sign_dispell_range = true
		speak('Throated agains! Needs to bye bye magic, find scroll somewhere!',2.5)
		nearest_box = area.get_parent()
	elif area.is_in_group('Doors'):
		is_near_a_locked_door = true
		nearest_door = area

func _on_area_2d_area_exited(area) -> void:
	if area.get_parent().name == "ShadowAreas":
		is_in_shadows = false
	elif area.get_parent().name == "Gnome" and not (is_in_shadows or is_boxed):
		speak('Bye bye gnome!', 1.0)
	elif area.is_in_group('Box'):
		is_near_box=false
		nearest_box = null
	elif area.is_in_group('Doors'):
		is_near_a_locked_door = false
		nearest_door = null

func is_spell_aquired() -> bool:
	var spell_aquired = Global.spells_aquired[spell_to_cast]
	if not spell_aquired:
		speak('No spell can cast! I not have it!', 1.5)
	return spell_aquired

func have_spell_ingredients():
	var have_spell_igredients = Global.check_spell_ingredients(spell_to_cast)
	if not have_spell_igredients:
		speak('No incrediments, no spell!', 1.5)
	return have_spell_igredients

func can_cast_spell() -> bool:
	return is_spell_aquired() and have_spell_ingredients()

func unlock_door() -> void:
	if nearest_door:
		match nearest_door.name:
			"Door1":
				Global.village_doors_unlocked[0] = true
			"Door2":
				Global.village_doors_unlocked[1] = true	
			"Door3":
				Global.village_doors_unlocked[2] = true
		nearest_door.queue_free()
		speak('Knocks-Knocks! Bye-bye door!', 2.5)

func on_captured() -> void:	
	for i in range(Global.ITEMS.size()):
		Global.ITEMS[i]['item_quantity'] = Global.ITEMS[i]['item_quantity'] /2 
	get_tree().reload_current_scene()

func enter_the_box() -> void:
	if nearest_box:
		is_boxed = true
		nearest_box.queue_free()

func create_trash_box() -> void:
	is_boxed = false
	var instance_box = trashed_box.instantiate()
	instance_box.position = global_position
	get_tree().get_root().add_child(instance_box)
	speak('Ooops, I brokes it.', 2.0)


func _on_area_2d_body_entered(body):
	if body.name == 'Gnome':
		on_captured()
