class_name GnomeIdleState
extends GnomeState

# Used to to find out how close we are to the last patrol location
const MINIMUM_DISTANCE_TO_REACH: float = 2.0

func enter() -> void:
	pass
	debug.text = name
	
func exit() -> void:
	pass
	debug.text = ""
	
func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	var gnome = parent as Gnome
	if is_detecting_goblin:
		return chasing_state
	else:
		if last_patrol_position.distance_to(gnome.global_position) <= MINIMUM_DISTANCE_TO_REACH:
			return patroling_state
		else:
			gnome.velocity = (last_patrol_position - gnome.global_position).normalized() * gnome.speed
			gnome.move_and_slide()
			return null
