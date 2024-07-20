class_name IdleState
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
	
# I had this idea on my shower, and I think it works much more elegantly.
# Each second, if the player is not inside a shador or is not hiding inside a 
# box, he will leave, at his current location, a marker. This marker will have 
# a life of two seconds, and it's this marker that has the 
# Area2D/CollisionShape2D logic and functionality. In essence, our enemies will
# chase the marker, not the player.

# This creates the trail discussed above.
func create_trail():
	var marker = goblin_marker.instantiate()
	marker.position = parent.global_position
	get_tree().get_root().add_child(marker)
