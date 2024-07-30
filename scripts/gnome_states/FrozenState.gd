class_name FrozenState
extends GnomeState

var timer:float

func enter() -> void:
	debug.text = name
	timer = 7.0
	(parent as Gnome).animationPlayer.play("Frozen")
	
func exit() -> void:
	debug.text = ""
	(parent as Gnome).animationPlayer.stop()

func process_physics(delta: float) -> State:
	var gnome = parent as Gnome
	timer -= 1 * delta
	if timer <= 0.0:
		gnome.is_frozen = false
		return gnome_idle_state
	else:
		AudioPlayerScene.play_fx(AudioPlayerScene.freeze_effect)
		return null
