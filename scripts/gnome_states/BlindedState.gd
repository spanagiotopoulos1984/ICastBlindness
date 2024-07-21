class_name BlindedState
extends GnomeState

var timer:float

func enter() -> void:
	debug.text = name
	timer = 5.0
	(parent as Gnome).animationPlayer.play("Blinded")
	
func exit() -> void:
	debug.text = ""
	(parent as Gnome).animationPlayer.stop()

func process_physics(delta: float) -> State:
	var gnome = parent as Gnome

	if gnome.is_frozen:
		return frozen_state
	
	timer -= 1 * delta
	if timer <=0 :
		gnome.is_blinded = false
		return gnome_idle_state
	else:
		return null
