extends Node2D

func _ready():
	if SceneManager.spawn_area:
		_on_level_spawn(SceneManager.spawn_area)	

func _on_level_spawn(destination: String)-> void:
	var exit_area = get_node('Exits/'+destination) as ExitArea
	SceneManager.spawn_player(exit_area.spawn_point.global_position, exit_area.spawn_direction)
