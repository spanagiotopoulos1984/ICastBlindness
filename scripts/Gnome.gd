class_name Gnome
extends AnimatedEntity

@onready var state_machine = $GnomeStateMachine

@export var is_frozen :bool = false

@export var is_blinded: bool = false

@export var is_detecting_goblin: bool = false

@export var last_known_posititon: Vector2
@export var last_patrol_position: Vector2

# Used to flip animations on x-axis, and  to disable the pesky rotation only
# on the image. Not the rest of the nodes.
@onready var sprite = $Sprite2D

@export var path_to_follow : PathFollow2D

func _ready():
	state_machine.init(self)

func _physics_process(delta):
	state_machine.process_physics(delta)

func _on_near_detection_area_area_entered(area):
	is_detecting_goblin = true
	last_known_posititon = area.global_position

func _on_near_detection_area_area_exited(area):
	is_detecting_goblin = false
