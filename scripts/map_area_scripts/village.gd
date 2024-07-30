extends Node2D

@onready var to_house_1 = $Exits/ToHouse1
@onready var to_house_2 = $Exits/ToHouse2
@onready var to_house_3 = $Exits/ToHouse3


func _ready():
	check_doors()
	if SceneManager.spawn_area:
		_on_level_spawn(SceneManager.spawn_area)	

func _on_level_spawn(destination: String)-> void:
	var exit_area = get_node('Exits/'+destination) as ExitArea
	SceneManager.spawn_player(exit_area.spawn_point.global_position, exit_area.spawn_direction)

func _process(_delta):
	check_doors()
			
func check_doors()-> void:
	# Check if entrances are unlocked, and if so, enabled the exit area (and graphics)
	to_house_1.set_process(Global.village_doors_unlocked[0])
	to_house_1.visible = Global.village_doors_unlocked[0]

	to_house_2.set_process(Global.village_doors_unlocked[1])
	to_house_2.visible = Global.village_doors_unlocked[1]
	
	to_house_3.set_process(Global.village_doors_unlocked[2])
	to_house_3.visible = Global.village_doors_unlocked[2]
		
			
