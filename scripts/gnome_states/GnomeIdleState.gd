class_name GnomeIdleStatewa
extends GnomeState

# A crude timer. Should be around 3 seconds. Starts when chase is enabled,
# ends if last_known_position remains like that for that amount of time.
# Again crude, but effective
var timer: float

func enter() -> void:
	debug.text = name
	timer = 1.5
	parent.animationPlayer.stop()
	
	
func exit() -> void:
	debug.text = ""
	
func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	var gnome = parent as Gnome
	
	if gnome.is_frozen:
		return frozen_state
		
	if gnome.is_blinded:
		return blinded_state
	
	if not gnome.is_detecting_goblin:
		timer -= 1.0 * delta
	else:
		AudioPlayerScene.play_fx(AudioPlayerScene.gnome_alerted)
		return chasing_state
	if timer > 0:
		return null
	else:
		return return_to_patrol_state
