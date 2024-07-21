extends BaseStateMachine

func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)
	
func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)
	
func process_frame(delta:float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
