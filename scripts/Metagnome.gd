extends CharacterBody2D

@export var speed: int = 80
@export var limit: float = 2

@onready var animation = $AnimationPlayer
@onready var patrol_timer = $PlayerSeekingTimer

# Used to initialize a point for our Metagnomes to patrol.
@export var start_marker: Marker2D
@export var end_marker: Marker2D

var starting_position: Vector2
var end_position: Vector2
var next_position: Vector2
var chase_player :bool = false


func _ready():
	starting_position = start_marker.global_position
	end_position = end_marker.global_position
	next_position = end_position
	position = starting_position

func change_direction():
	var distance_to_start = position.distance_to(start_marker.position)
	var distance_to_end = position.distance_to(end_marker.position)
	
	if distance_to_start >= limit and (distance_to_start >= distance_to_end):
		starting_position = end_marker.position
		end_position = start_marker.position
	elif distance_to_end >= limit and (distance_to_end >= distance_to_start):
		starting_position = start_marker.position
		end_position = end_marker.position
	elif distance_to_start < limit:
		starting_position = start_marker.position
		end_position = end_marker.position
	elif distance_to_end < limit:
		starting_position = end_marker.position
		end_position = start_marker.position
	

func update_velocity():
	if not chase_player:
		if position.distance_to(next_position) <= limit:
			change_direction()
		else:
			var move_direction = next_position - position
			velocity = move_direction.normalized() * speed

# This is re-used between goblin and metagnome. 
# If time permits, I will refactor into a common class.
func updateAnimation():
	if velocity.y > 0 and velocity.x > 0:
		animation.play("Walk_Down_Right")
	elif velocity.y > 0 and velocity.x < 0:
		animation.play("Walk_Down_Left")
	elif velocity.y > 0 and velocity.x == 0:
		animation.play("Walk_Down")
	elif velocity.y == 0 and velocity.x > 0:
		animation.play("Walk_Right")
	elif velocity.y == 0 and velocity.x < 0:
		animation.play("Walk_Left")
	elif velocity.y < 0 and velocity.x > 0:
		animation.play("Walk_Down_Right")
	elif velocity.y < 0 and velocity.x < 0:
		animation.play("Walk_Down_Left")
	elif velocity.y < 0 and velocity.x == 0:
		animation.play("Walk_Down")
	else:
		if animation.is_playing():
			animation.stop()

func _physics_process(_delta):
	update_velocity()
	move_and_slide()
	updateAnimation()

func _on_player_seeking_timer_timeout():
	print("Player no longer detected")
	pass # Replace with function body.


func _on_vision_detection_zone_body_entered(body):
	
	pass # Replace with function body.
