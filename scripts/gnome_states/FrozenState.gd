class_name FrozenState
extends GnomeState

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
	return null
