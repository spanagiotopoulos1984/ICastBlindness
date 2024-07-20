class_name GoblinState 
extends State

@export var casting_state: State
@export var moving_state: State
@export var idle_state: State
@export var hiding_idle_state: State
@export var hiding_moving_state: State
@export var box_idle_state: State
@export var box_moving_state: State

# Preload allows us to 	preload() load a resource when the game starts, 
# before any scripts are run. This can be useful for resources that will be used
# immediately and frequently throughout your game to eliminate delays caused by 
# loading them on-demand.
@onready var goblin_marker = preload("res://scenes/goblin_marker.tscn")

var is_in_shadows: bool = false

func create_trail():
	pass
