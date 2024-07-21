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
	var goblin = parent as Goblin
	if event:
		if Input.is_action_just_pressed("Cast Blindness"):
			goblin.spell_to_cast = CASTABLE.BLINDNESS
			return casting_state
		elif Input.is_action_just_pressed("Cast Freeze"):
			goblin.spell_to_cast = CASTABLE.FREEZE
			return casting_state
		elif Input.is_action_just_pressed("Cast Sound"):
			goblin.spell_to_cast = CASTABLE.SOUND
			return casting_state
		elif Input.is_action_just_pressed("Cast Unlock"):
			goblin.spell_to_cast = CASTABLE.UNLOCK
			return casting_state
	
	goblin.spell_to_cast = CASTABLE.NONE
	
	if (Input.is_action_pressed("player_down") or 
	Input.is_action_pressed("player_up") or 
	Input.is_action_pressed("player_left") or 
	Input.is_action_pressed("player_right")):
		if (parent as Goblin).is_in_shadows:
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
