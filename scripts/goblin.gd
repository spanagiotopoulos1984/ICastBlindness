extends CharacterBody2D

# We are using CharacterBody2D for the player
# in order to be able to move the player programmatically,
# and not depend on the physics engine.
# See https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html

# Using @export means that this property will be visible by the editor
# making it easy to view, tweak and debug!
@export var speed: int = 150

# @onready is just shorthand for initializing a variable in the _ready function.
# It executes before _ready(), so it can also be used if we definitely need
# something to be executed before anything else.The ready function runs when the
# node is ready, or in other words, when all the children of the current node 
# have executed their ready functions, the parent ready function will run. This 
# is mostly helpful to ensure that references to child nodes will be available 
# and won't throw null reference errors.
# The $AnimationPlayer is just a reference to a node from the editor.
@onready var animation = $AnimationPlayer

# A function to handle player input. We have defined the available inputs in 
# Project/Project Settings/Input Map, and we use these inputs here to decide on
# how to move the player. Take note, the variable velocity is a Godot variable
# that is used to decite where and how fast the player will move. (Remember, in 
# physics Velocity is a Vector, of direction and amplitude. Same in Godot, it is
# a Vector2D, which means it has the direction and the speed of change).
func handle_input():
	# Input.get_vector returns a Vector2D, and accepts inputs in the direction
	# l,r,u,d
	var movement_direction = Input.get_vector("player_left","player_right","player_up","player_down")
	velocity = movement_direction * speed	

# This function updates the Animation sheet, depending on what the player does.
# For the moment, it will be only movement.
# Since we have no sprites for diagonals, I will always assume their animations
# are the respective up/down animations, while moving a bit left or right too.
func updateAnimation():
	# Player no longer moves. Set the idle sprite to the appropriate one.
	# The way this if is structured, we give priority to up/down animations. 
	# This is on purpose, since we want to use this animations for the diagonals
	# as well.
	if velocity.length() == 0:		
		# Stop an animation only if it is playing. To avoid errors.
		if animation.is_playing():
			animation.stop()
	elif velocity.y > 0:
		animation.play("Walk_Down")
	elif velocity.y < 0:
		animation.play("Walk_Up")
	elif velocity.x > 0:
		animation.play("Walk_Right")
	elif velocity.x < 0:
		animation.play("Walk_Left")
	

# Called during the physics processing step of the main loop.
# Calls our handle_input function, and then uses the godot internal
# move_and_slide() to actually move the player
func _physics_process(_delta):
	handle_input()
	move_and_slide()
	updateAnimation()


func _on_hitbox_area_entered(area):
	if area.name == "Hitbox":
		print("I am caught!")
	pass # Replace with function body.
