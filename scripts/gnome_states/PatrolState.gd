class_name PatrolState
extends GnomeState

var velocity

func enter() -> void:
	debug.text = name
	
func exit() -> void:
	debug.text = ""
	var gnome = parent as Gnome
	gnome.last_patrol_position  = parent.global_position

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	var gnome = parent as Gnome
	
	if gnome.is_frozen:
		return frozen_state
		
	if gnome.is_blinded:
		return blinded_state
	
	if gnome.is_detecting_goblin:
		return chasing_state
	else:
		var gnome_parent = parent as Gnome
		var old_position = gnome_parent.sprite.global_position
		gnome_parent.path_follow.progress += gnome_parent.speed * delta
		gnome_parent.sprite.global_rotation  = 0
		var new_position = gnome_parent.sprite.global_position
		var velocity = new_position - old_position
		update_animation(velocity)
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
