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

func _on_near_detection_area_area_entered(area: Area2D):
	for state in get_children():
		var gnome_state = state as GnomeState
		var goblin_marker = area.get_parent().get_child(0) as Marker2D
		gnome_state.is_detecting_goblin = true
		gnome_state.last_known_posititon = goblin_marker.global_position


func _on_near_detection_area_area_exited(area: Area2D):
	for state in get_children():
		var gnome_state = state as GnomeState
		gnome_state.is_detecting_goblin = false
