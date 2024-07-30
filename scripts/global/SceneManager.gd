extends Node

const start = preload("res://scenes/maps/start.tscn")
const forest_main = preload("res://scenes/maps/forest_main.tscn")
const forest_up = preload("res://scenes/maps/forest_up.tscn")
const forest_left = preload("res://scenes/maps/forest_left.tscn")
const village = preload("res://scenes/maps/village.tscn")
const house1 = preload("res://scenes/maps/house1.tscn")
const house2 = preload("res://scenes/maps/house2.tscn")
const house3 = preload("res://scenes/maps/house3.tscn")
const bakery = preload("res://scenes/maps/bakery.tscn")

var spawn_area

signal on_player_spawn

func move_to_scene(scene: String, destination: String):
	var scene_to_load
	
	match scene:
		'start':
			scene_to_load = start	
		'forest_main':
			scene_to_load = forest_main		
		'forest_up':
			scene_to_load = forest_up		
		'forest_left':
			scene_to_load = forest_left	
		'village':
			scene_to_load = village
		'house1':
			scene_to_load = house1
		'house2':
			scene_to_load = house2
		'house3':
			scene_to_load = house3
		'bakery':
			scene_to_load = bakery
			
	if scene_to_load:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_packed(scene_to_load)
		spawn_area = destination

func spawn_player(position: Vector2, direction: String):
	on_player_spawn.emit(position,direction)
