class_name PatrolState
extends GnomeState

var velocity

func enter() -> void:
	debug.text = name
	
func exit() -> void:
	debug.text = ""
	for state in get_parent().get_children():
		var gnome_state = state as GnomeState
		print(gnome_state.name)
		gnome_state.last_patrol_position = parent.global_position
		#print("Last Patrol Point: ",last_patrol_position)

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	if is_detecting_goblin:
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
	if(velocity.x > 0 and velocity.y > 0):
		animation_name = "Walk_Down_Right"
	elif(velocity.x > 0 and velocity.y == -1):
		animation_name = "Walk_Up_Right"
	elif(velocity.x > 0 and velocity.y == 0):
		animation_name = "Walk_Right"
	elif(velocity.x < 0 and velocity.y > 0):
		animation_name = "Walk_Down_Left"
	elif(velocity.x < 0 and velocity.y < 0):
		animation_name = "Walk_Up_Left"
	elif(velocity.x < 0 and velocity.y == 0):
		animation_name = "Walk_Left"
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
