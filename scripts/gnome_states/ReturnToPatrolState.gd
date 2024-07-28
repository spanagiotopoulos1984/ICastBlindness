class_name ReturnToPatrolState
extends GnomeState

# Used to to find out how close we are to the last patrol location
const MINIMUM_DISTANCE_TO_REACH: float = 1.5

func enter() -> void:
	pass
	parent.speed = 100
	debug.text = name
	
func exit() -> void:
	pass
	debug.text = ""
	
func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	var gnome = parent as Gnome
	
	if gnome.is_frozen:
		return frozen_state
		
	if gnome.is_blinded:
		return blinded_state
	
	if gnome.is_detecting_goblin:
		return chasing_state
	else:
		if gnome.last_patrol_position.distance_to(gnome.global_position) <= MINIMUM_DISTANCE_TO_REACH:
			return patroling_state
		else:
			gnome.velocity = (gnome.last_patrol_position - gnome.global_position).normalized() * gnome.speed
			update_animation(gnome.velocity)
			gnome.move_and_slide()
			return null

func update_animation(velocity: Vector2):
	var is_moving = true
	var gnome = parent as Gnome
	gnome.sprite.flip_h = velocity.x < 0
	if(velocity.x > 0 and velocity.y > 0):
		animation_name = "Walk_Down_Right"
	elif(velocity.x > 0 and velocity.y == -1):
		animation_name = "Walk_Up_Right"
	elif(velocity.x > 0 and velocity.y == 0):
		animation_name = "Walk_Right"
	elif(velocity.x < 0 and velocity.y > 0):
		animation_name = "Walk_Down_Right"
	elif(velocity.x < 0 and velocity.y < 0):
		animation_name = "Walk_Up_Right"
	elif(velocity.x < 0 and velocity.y == 0):
		animation_name = "Walk_Right"
	elif(velocity.x == 0 and velocity.y > 0):
		animation_name = "Walk_Down"
	elif(velocity.x == 0 and velocity.y < 0):
		animation_name = "Walk_Up"
	else:
		is_moving = false
	if is_moving:
		parent.animationPlayer.play(animation_name)
	else:
		parent.animationPlayer.stop()
