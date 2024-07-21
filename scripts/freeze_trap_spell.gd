class_name FreezeTrapSpell
extends Area2D

@onready var animation_player : AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("Freeze")


func _on_body_entered(body):
	if body is Gnome:
		var gnome = body as Gnome
		gnome.is_frozen = true
		queue_free()

# Remove trap when timer runs out
func _on_timer_timeout():
	queue_free()
