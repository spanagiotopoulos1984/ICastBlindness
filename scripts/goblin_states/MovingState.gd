class_name MovingState
extends GoblinState

var movement_direction: Vector2
var is_moving: bool

func enter() -> void:
	super()	
	#parent.velocity = Vector2.ZERO
	#parent.animationPlayer.stop()
	debug.text = name
	process_input(null)
	process_physics(0)
	
func exit() -> void:
	super()
	
func process_input(event: InputEvent) -> State:
	var is_moving = true
	
	movement_direction = handle_user_input()
	
	if(movement_direction.x == 1 and movement_direction.y == 1):
		animation_name = "Normal_Walk_Down_Right"
	elif(movement_direction.x == 1 and movement_direction.y == -1):
		animation_name = "Normal_Walk_Up_Right"
	elif(movement_direction.x == 1 and movement_direction.y == 0):
		animation_name = "Normal_Walk_Right"
	elif(movement_direction.x == -1 and movement_direction.y == 1):
		animation_name = "Normal_Walk_Down_Left"
	elif(movement_direction.x == -1 and movement_direction.y == -1):
		animation_name = "Normal_Walk_Up_Left"
	elif(movement_direction.x == -1 and movement_direction.y == 0):
		animation_name = "Normal_Walk_Left"
	elif(movement_direction.x == 0 and movement_direction.y == 1):
		animation_name = "Normal_Walk_Down"
	elif(movement_direction.x == 0 and movement_direction.y == -1):
		animation_name = "Normal_Walk_Up"
	else:
		is_moving = false
	
	if not is_moving:
		if is_in_shadows:
			return hiding_idle_state
		else:
			return idle_state
			
	if is_in_shadows:
		return hiding_moving_state
	else:
		return null

		
func process_frame(_delta: float) -> State:
	return null

# We process physics. If during the physics process we did somethiing tthat should change
# our state, we return this to the state machine. Otherwise, we return null
func process_physics(_delta: float) -> State:
	parent.animationPlayer.play(animation_name)
	parent.velocity = movement_direction * parent.speed
	parent.move_and_slide()
	return null

func handle_user_input() -> Vector2:
	return Vector2(Input.get_axis('player_left', 'player_right'), Input.get_axis('player_up', 'player_down'))

func create_trail():
	var marker = goblin_marker.instantiate()
	marker.position = parent.global_position
	get_tree().get_root().add_child(marker)
