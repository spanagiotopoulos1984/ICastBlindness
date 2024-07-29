extends GoblinState

func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO
	debug.text = name
	parent.animationPlayer.stop()
	
func exit() -> void:
	debug.text = ""
	
func process_input(_event: InputEvent) -> State:
	var goblin = parent as Goblin
	if Input.is_action_just_pressed("Cast Blindness"):
		goblin.spell_to_cast = CASTABLE.BLINDNESS
		if goblin.can_cast_spell():
			return casting_state
	elif Input.is_action_just_pressed("Cast Freeze"):
		goblin.spell_to_cast = CASTABLE.FREEZE
		if goblin.can_cast_spell():
			return casting_state
	elif Input.is_action_just_pressed("Cast Sound"):
		goblin.spell_to_cast = CASTABLE.SOUND
		if goblin.can_cast_spell():
			return casting_state
	elif Input.is_action_just_pressed("Cast Unlock"):
		goblin.spell_to_cast = CASTABLE.UNLOCK
		if goblin.can_cast_spell():
			return casting_state
	elif Input.is_action_just_pressed("cast_fireball"):
		goblin.spell_to_cast = CASTABLE.FIREBALL
		if goblin.can_cast_spell():
			return casting_state
	elif Input.is_action_just_pressed("cast_dispell"):
		goblin.spell_to_cast = CASTABLE.DISPELL
		if goblin.can_cast_spell():
			return casting_state
		
	goblin.spell_to_cast = CASTABLE.NONE
	
	if (Input.is_action_pressed("player_down") or 
	Input.is_action_pressed("player_up") or 
	Input.is_action_pressed("player_left") or 
	Input.is_action_pressed("player_right")):
		return box_moving_state
	else:
		return null
		
func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	parent.move_and_slide()
	return null

func create_trail():
	pass
