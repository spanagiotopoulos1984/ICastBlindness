class_name ExitArea
extends Area2D


@export var destination_level: String
@export var destination_door: String
@export var spawn_direction = 'UP'

@onready var spawn_point = $SpawnPoint


func _on_body_entered(body):
	if body.is_in_group('Player'):
		SceneManager.move_to_scene(destination_level,destination_door)
