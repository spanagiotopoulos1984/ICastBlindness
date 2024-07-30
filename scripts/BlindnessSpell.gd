class_name BlindnessSpellProjective
extends Area2D

var speed : float = 150.0
var direction : Vector2

@onready var  animation_player = $AnimationPlayer

func _ready():
	animation_player.play("Blindness_Particle")

func _physics_process(delta):
	position += direction * speed * delta

# If the timer times-out, the spell fizzles and disappears.
func _on_timer_timeout():
	queue_free()

# Happens when a Layer 2 object (A gnome) passes through the area
func _on_body_entered(body):
	if body is Gnome:
		var gnome = body as Gnome
		gnome.is_blinded = true
		queue_free()
