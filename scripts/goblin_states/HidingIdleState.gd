class_name HidingIdleState
extends GoblinState

func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO
	parent.animationPlayer.stop()
	debug.text = name
	
func exit() -> void:
	debug.text = ""
	
func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("player_down") or Input.is_action_just_pressed("player_up") or Input.is_action_just_pressed("player_left") or Input.is_action_just_pressed("player_right"):
		if is_in_shadows:
			return hiding_moving_state
		else:
			return moving_state
	else:
		return null
		
func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	parent.move_and_slide()
	return null

func create_trail():
	pass
