extends GoblinState

var movement_direction: Vector2
var is_moving: bool

# Box movement should be slow and careful. If you move for a long enough distance
# then the box should be trashed. Resets after returning to this state from another.
var time_in_movement = 5

func enter() -> void:
	super()	
	debug.text = name
	process_input(null)
	process_physics(0)
	
func exit() -> void:
	super()
	
func process_input(_event: InputEvent) -> State:
	is_moving = true
	var goblin = parent as Goblin
	movement_direction = handle_user_input()
	
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
	
	if(movement_direction.x == 1 and movement_direction.y == 1):
		animation_name = "Box_Walk_Down_Right"
		goblin.last_direction = DIRECTION.DOWN_RIGHT
		goblin.sprite.flip_h = false
	elif(movement_direction.x == 1 and movement_direction.y == -1):
		animation_name = "Box_Walk_Up_Right"
		goblin.last_direction = DIRECTION.UP_RIGHT
		goblin.sprite.flip_h = false
	elif(movement_direction.x == 1 and movement_direction.y == 0):
		animation_name = "Box_Walk_Right"
		goblin.last_direction = DIRECTION.RIGHT
		goblin.sprite.flip_h = false
	elif(movement_direction.x == -1 and movement_direction.y == 1):
		animation_name = "Box_Walk_Down_Right"
		goblin.last_direction = DIRECTION.DOWN_LEFT
		goblin.sprite.flip_h = true
	elif(movement_direction.x == -1 and movement_direction.y == -1):
		animation_name = "Box_Walk_Up_Right"
		goblin.last_direction = DIRECTION.UP_LEFT
		goblin.sprite.flip_h = true
	elif(movement_direction.x == -1 and movement_direction.y == 0):
		animation_name = "Box_Walk_Right"
		goblin.last_direction = DIRECTION.LEFT
		goblin.sprite.flip_h = true
	elif(movement_direction.x == 0 and movement_direction.y == 1):
		animation_name = "Box_Walk_Down"
		goblin.last_direction = DIRECTION.DOWN
		goblin.sprite.flip_h = false
	elif(movement_direction.x == 0 and movement_direction.y == -1):
		animation_name = "Box_Walk_Up"
		goblin.last_direction = DIRECTION.UP
		goblin.sprite.flip_h = false
	else:
		is_moving = false
	
	if not is_moving:
		time_in_movement = 5
		return box_idle_state		

	if (time_in_movement<0):
		goblin.create_trash_box()
		return moving_state

	return box_moving_state
		
func process_frame(delta: float) -> State:
	return null

# We process physics. If during the physics process we did somethiing tthat should change
# our state, we return this to the state machine. Otherwise, we return null
func process_physics(delta: float) -> State:
	time_in_movement -= 2 * delta
	parent.animationPlayer.play(animation_name)
	parent.velocity = movement_direction.normalized() * parent.speed /2 
	parent.move_and_slide()
	return null

func handle_user_input() -> Vector2:
	return Vector2(Input.get_axis('player_left', 'player_right'), Input.get_axis('player_up', 'player_down'))
	
func create_trail():
	pass
