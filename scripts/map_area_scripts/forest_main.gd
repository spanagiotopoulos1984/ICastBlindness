extends Node2D

const ENUM = preload("res://scripts/Enum.gd")
const DIRECTION = ENUM.Direction
const CASTABLE = ENUM.CASTABLE_SPELL

@onready var village_passage_denier = $TileMap/VillagePassageDenier

func _ready():
	Global.spell_casted.connect(_on_spell_casted)
	
	if Global.is_village_way_open:
		village_passage_denier.set_process(false)
		village_passage_denier.visible = false
	else:
		if SceneManager.spawn_area:
			_on_level_spawn(SceneManager.spawn_area)	

func _on_level_spawn(destination: String)-> void:
	var exit_area = get_node('Exits/'+destination) as ExitArea
	SceneManager.spawn_player(exit_area.spawn_point.global_position, exit_area.spawn_direction)

func _on_spell_casted(spell: CASTABLE):
	if village_passage_denier:
		Global.is_village_way_open = true
		village_passage_denier.queue_free()
