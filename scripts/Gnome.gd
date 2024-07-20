class_name Gnome
extends AnimatedEntity

@onready var patrol_timer = $PlayerSeekingTimer

@onready var state_machine = $GnomeStateMachine

@onready var path_follow : PathFollow2D = $".."

@onready var alert_timer : Timer = $AlertTiimer

# Required to disable the pesky rotation only on the image. Not the rest
# of the nodes.
@onready var sprite = $Sprite2D

func _ready():
	state_machine.init(self)

func _physics_process(delta):
	state_machine.process_physics(delta)
