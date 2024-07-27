class_name GoblinStateMachine
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

func update_shadoow_state() -> void:
	for state in get_children():
		state.is_in_shadows = false

# This makes sense only for the Goblin
func create_trail() -> void:
	current_state.create_trail()
