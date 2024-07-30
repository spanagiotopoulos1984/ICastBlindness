class_name CastingState
extends GoblinState

var timer : float

var goblin = null

func enter() -> void:
	super()
	goblin = parent as Goblin
	debug.text = name
	parent.velocity = Vector2.ZERO
	timer = 0.8
	begin_casting_animation()	
	
func exit() -> void:
	debug.text = ""
	
func process_input(_event: InputEvent) -> State:
	return null
		
func process_frame(_delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	if Input.is_action_just_pressed("Inventory"):
		goblin.enter_or_exit_inventory_screen()
		return null
	elif timer <= 0:
		cast_spell((parent as Goblin).spell_to_cast)
		if (Input.is_action_pressed("player_down") or 
			Input.is_action_pressed("player_up") or 
			Input.is_action_pressed("player_left") or 
			Input.is_action_pressed("player_right")):
				if (parent as Goblin).is_in_shadows:
					return hiding_moving_state
				return moving_state
		else:
			if (parent as Goblin).is_in_shadows:
				return hiding_idle_state
			return idle_state
	else:
		create_trail()
		timer -= delta
		return null
	
func begin_casting_animation() -> void:
	match goblin.last_direction:
			DIRECTION.UP:
				goblin.sprite.flip_h = false
				goblin.animationPlayer.play("Casting_Up")
			DIRECTION.UP_LEFT:
				goblin.sprite.flip_h = true
				goblin.animationPlayer.play("Casting_Up_Right")
			DIRECTION.UP_RIGHT:
				goblin.sprite.flip_h = false
				goblin.animationPlayer.play("Casting_Up_Right")
			DIRECTION.LEFT:
				goblin.sprite.flip_h = true
				goblin.animationPlayer.play("Casting_Right")
			DIRECTION.RIGHT:
				goblin.sprite.flip_h = false
				goblin.animationPlayer.play("Casting_Right")
			DIRECTION.DOWN_LEFT:
				goblin.sprite.flip_h = true
				goblin.animationPlayer.play("Casting_Down_Right")
			DIRECTION.DOWN_RIGHT:
				goblin.sprite.flip_h = false
				goblin.animationPlayer.play("Casting_Down_Right")
			DIRECTION.DOWN:
				goblin.sprite.flip_h = true
				goblin.animationPlayer.play("Casting_Down")
			_:
				print("Last known Direction should never be empty.")

func create_trail():
	var marker = goblin_marker.instantiate()
	marker.position = parent.global_position
	get_tree().get_root().add_child(marker)

func cast_sound():
	const SOUND_DISTANCE = 20
	const DISTANCE_MODIFIER = 8
	var marker = goblin_marker.instantiate()
	marker.position = parent.global_position
	marker.scale.x = 3.0
	marker.scale.y = 3.0
	match goblin.last_direction:
		DIRECTION.UP:
			marker.position.y -= SOUND_DISTANCE * DISTANCE_MODIFIER
		DIRECTION.DOWN:
			marker.position.y += SOUND_DISTANCE * DISTANCE_MODIFIER
		DIRECTION.LEFT:
			marker.position.x -= SOUND_DISTANCE * DISTANCE_MODIFIER
		DIRECTION.RIGHT:
			marker.position.x += SOUND_DISTANCE * DISTANCE_MODIFIER
		DIRECTION.UP_LEFT:
			marker.position.x -= SOUND_DISTANCE * DISTANCE_MODIFIER
			marker.position.y -= SOUND_DISTANCE * DISTANCE_MODIFIER
		DIRECTION.UP_RIGHT:
			marker.position.x += SOUND_DISTANCE * DISTANCE_MODIFIER
			marker.position.y -= SOUND_DISTANCE * DISTANCE_MODIFIER
		DIRECTION.DOWN_LEFT:
			marker.position.x -= SOUND_DISTANCE * DISTANCE_MODIFIER
			marker.position.y += SOUND_DISTANCE * DISTANCE_MODIFIER
		DIRECTION.DOWN_RIGHT:
			marker.position.x += SOUND_DISTANCE * DISTANCE_MODIFIER
			marker.position.y += SOUND_DISTANCE * DISTANCE_MODIFIER
	get_tree().get_root().add_child(marker)
	AudioPlayerScene.play_fx(AudioPlayerScene.boing)
	Global.spell_casted.emit(CASTABLE.SOUND)
	
func cast_blindness():
	var wand_marker = (parent as Goblin).wand_marker
	var blindness_projectile : BlindnessSpellProjective = blindness_spell.instantiate()
	get_tree().get_root().add_child(blindness_projectile)
	blindness_projectile.position = wand_marker.global_position
	match (parent as Goblin).last_direction:
		DIRECTION.UP:
			blindness_projectile.direction = Vector2(0,-1)
		DIRECTION.DOWN:
			blindness_projectile.direction = Vector2(0,1)
		DIRECTION.LEFT:
			blindness_projectile.direction = Vector2(-1,0)
		DIRECTION.RIGHT:
			blindness_projectile.direction = Vector2(1,0)
		DIRECTION.UP_LEFT:
			blindness_projectile.direction = Vector2(-1,-1)
		DIRECTION.UP_RIGHT:
			blindness_projectile.direction = Vector2(1,-1)
		DIRECTION.DOWN_LEFT:
			blindness_projectile.direction = Vector2(-1,1)
		DIRECTION.DOWN_RIGHT:
			blindness_projectile.direction = Vector2(1,1)
	AudioPlayerScene.play_fx(AudioPlayerScene.blindness)
	Global.spell_casted.emit(CASTABLE.BLINDNESS)
	
func cast_unlock()-> void:
	var goblin = parent as Goblin
	if goblin.is_near_a_locked_door:
		AudioPlayerScene.play_fx(AudioPlayerScene.knock_knock)
		Global.spell_casted.emit(CASTABLE.UNLOCK)
	else:
		goblin.speak('Knock-knock what door?',2.5)
	
func cast_dispell()-> void:
	var goblin = parent as Goblin
	if goblin.in_sign_dispell_range:
		AudioPlayerScene.play_fx(AudioPlayerScene.dispel)
		Global.spell_casted.emit(CASTABLE.DISPELL)
	else:
		goblin.speak('No waste prettious incrediments!',2.5)
	
func cast_fireball()-> void:
	AudioPlayerScene.play_fx(AudioPlayerScene.fireball)
	Global.spell_casted.emit(CASTABLE.FIREBALL)
	
func cast_freeze() -> void:
	var wand_marker = (parent as Goblin).wand_marker
	var freeze_spell_projectile : FreezeTrapSpell = freeze_spell.instantiate()
	get_tree().get_root().add_child(freeze_spell_projectile)
	freeze_spell_projectile.position = wand_marker.global_position
	AudioPlayerScene.play_fx(AudioPlayerScene.freeze)
	Global.spell_casted.emit(CASTABLE.FREEZE)

func cast_spell(spell: CASTABLE) -> void:
	match spell:
		CASTABLE.NONE:
			print_debug("No spell has been selected. Why are we casting?")
		CASTABLE.SOUND:
			cast_sound()
		CASTABLE.BLINDNESS:
			cast_blindness()
		CASTABLE.UNLOCK:
			cast_unlock()
		CASTABLE.FREEZE:
			cast_freeze()
		CASTABLE.DISPELL:
			cast_dispell()
		CASTABLE.FIREBALL:
			cast_fireball()
		_:
			print_debug("Unknown spell selected. A bug.")

