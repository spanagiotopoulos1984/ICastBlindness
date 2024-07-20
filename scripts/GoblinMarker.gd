extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Signals

# This will timeout after 2 seconds, destroying the marker.
func _on_timer_timeout():
	queue_free()

# This is for debugging purposes. It is emitted when another area enters this
# one. p.ex. Detection event
func _on_area_entered(area):
	pass
	#print("I am detected by " + area.name)
	
	# This is for debugging purposes. It is emitted when another area enters this
# one. p.ex. Detection event
func _on_area_exited(area):
	pass
	#print("I am no longer detected by " + area.name)
