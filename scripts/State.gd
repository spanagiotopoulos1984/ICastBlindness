class_name State 
extends Node

@export var animation_name: String

@onready var debug = owner.find_child("StateDebugText")

var parent: AnimatedEntity

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
