class_name ChaseState
extends GnomeState

const MINIMUM_DISTANCE_TO_FOLLOW: float = 10.0

# A float that keeps a distance tot the last known goblin position. If it
# reaches 0, the gnome remains at that position for 3 seconds, then returns
# to its patroling.
var distance_to_marker : float

func enter() -> void:
	debug.text = name
	
func exit() -> void:
	debug.text = ""
	
func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	var gnome = parent as Gnome
	if last_known_posititon:
		
		if last_known_posititon.distance_to(gnome.global_position) <= MINIMUM_DISTANCE_TO_FOLLOW:
			return gnome_idle_state
	
		gnome.velocity = (last_known_posititon - gnome.global_position).normalized() * gnome.speed
		gnome.move_and_slide()
		return null
	else:
		return patroling_state
