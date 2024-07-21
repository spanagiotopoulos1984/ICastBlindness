class_name ChaseState
extends GnomeState

const MINIMUM_DISTANCE_TO_FOLLOW: float = 10.0

# A float that keeps a distance tot the last known goblin position. If it
# reaches 0, the gnome remains at that position for 3 seconds, then returns
# to its patroling.
var distance_to_marker : float

func enter() -> void:
	debug.text = name
	
func exit() -> void:
	debug.text = ""
	
func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	var gnome = parent as Gnome
	
	if gnome.is_blinded:
		return blinded_state
	
	if gnome.last_known_posititon:
		
		if gnome.last_known_posititon.distance_to(gnome.global_position) <= MINIMUM_DISTANCE_TO_FOLLOW:
			return gnome_idle_state
	
		gnome.velocity = (gnome.last_known_posititon - gnome.global_position).normalized() * gnome.speed
		update_animation(gnome.velocity)
		gnome.move_and_slide()
		return null
	else:
		return patroling_state

func update_animation(velocity: Vector2):
	var is_moving = true
	var gnome = parent as Gnome
	gnome.sprite.flip_h = velocity.x < 0
	if(velocity.x > 0 and velocity.y > 0):
		animation_name = "Alert_Walk_Down_Right"
	elif(velocity.x > 0 and velocity.y == -1):
		animation_name = "Alert_Walk_Up_Right"
	elif(velocity.x > 0 and velocity.y == 0):
		animation_name = "Alert_Walk_Right"
	elif(velocity.x < 0 and velocity.y > 0):
		animation_name = "Alert_Walk_Down_Right"
	elif(velocity.x < 0 and velocity.y < 0):
		animation_name = "Alert_Walk_Up_Right"
	elif(velocity.x < 0 and velocity.y == 0):
		animation_name = "Alert_Walk_Right"
	elif(velocity.x == 0 and velocity.y > 0):
		animation_name = "Alert_Walk_Down"
	elif(velocity.x == 0 and velocity.y < 0):
		animation_name = "Alert_Walk_Up"
	else:
		is_moving = false
	if is_moving:
		parent.animationPlayer.play(animation_name)
	else:
		parent.animationPlayer.stop()
