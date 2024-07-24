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
	var goblin = parent as Goblin
	
	if Input.is_action_just_pressed("Inventory"):
		goblin.enter_or_exit_inventory_screen()
		return null
	elif Input.is_action_just_pressed("Cast Blindness"):
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
