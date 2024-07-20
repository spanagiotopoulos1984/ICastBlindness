class_name GnomeIdleStatewa
extends GnomeState

# A crude timer. Should be around 3 seconds. Starts when chase is enabled,
# ends if last_known_position remains like that for that amount of time.
# Again crude, but effective
var timer: float

func enter() -> void:
	debug.text = name
	timer = 3.0
	
func exit() -> void:
	debug.text = ""
	
func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	if not is_detecting_goblin:
		timer -= 1.0 * delta
	else:
		return chasing_state
	print(timer)
	if timer > 0:
		return null
	else:
		return return_to_patrol_state
