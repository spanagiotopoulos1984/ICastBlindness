class_name AnimatedEntity
extends CharacterBody2D

# We are using CharacterBody2D for the player and the enemy
# in order to be able to move them programmatically,
# and not depend on the physics engine.
# See https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html

# Using @export means that this property will be visible by the editor
# making it easy to view, tweak and debug!
@export var speed: int = 150

@export var animationPlayer: AnimationPlayer
