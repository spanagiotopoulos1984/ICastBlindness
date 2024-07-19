extends Node

class_name State

@onready var debug = owner.find_child("Debug")
@onready var goblin = owner.get_parent().find_child("Goblin")

func _ready():
	set_physics_process(false)
	
func enter():
	set_physics_process(true	)
	
func exit():
	set_physics_process(false)
	
func transition():
	pass
	
func _physics_process(_delta):
	transition()
	debug.text = name
