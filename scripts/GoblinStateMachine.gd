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

func update_shadoow_state():
	for state in get_children():
		state.is_in_shadows = false

# This makes sense only for the Goblin
func create_trail():
	var gstate = current_state as GoblinState
	current_state.create_trail()

# Inelegant solutions to a simple problem. I will have to revisit how to
# combine area 2D terrain collision detections and Character2D state machines.
# For now, as long as it works, it stays.

func _on_area_2d_area_entered(area):
	if area.get_parent().name == "ShadowAreas":
		for state in get_children():
			state.is_in_shadows = true


func _on_area_2d_area_exited(area):
	if area.get_parent().name == "ShadowAreas":
		for state in get_children():
			state.is_in_shadows = false
