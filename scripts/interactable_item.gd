@tool 
class_name InteractableItem
extends Node2D

@export var item_name: String
@export var item_texture: Texture2D

@onready var icon_sprite : Sprite2D = $Sprite2D
@onready var pointer_icon : AnimatedSprite2D = $Pointer
@onready var tingle : AnimatedSprite2D = $Tingle

var player_in_range: bool

var scene_path = "res://scenes/interactable_item.tscn"

func _ready():
	# At start, set the texture of the item on ground,
	# start the pointer animation and make sure the 
	# tingle animation is not visible.
	
	match item_name:
		'backpack':
			var is_picked :bool = Global.is_backpack_picked
			set_process(!is_picked)
			visible = !is_picked
		
	
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture
		
		pointer_icon.play()
		
		tingle.visible=false
		tingle.stop()
		tingle.frame=0

func _process(_delta):
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture
		
	if player_in_range and Input.is_action_just_pressed("pick_up_item"):
		pick_up_item()

func pick_up_item() -> void:
	if Global.goblin_node:
	
		match item_name:
			'backpack':
				Global.add_inventory_item(Global.ITEMS[0],5)
				Global.add_spell(0)
				Global.goblin_node.speak('Backpacks! Has spell, and incrediments!',2.0)
				Global.is_backpack_picked = true
	
		# Make the icon invisible (to signify it's been picked up
		icon_sprite.visible = false
		
		# Play the tingle animation (so player has feedback)
		tingle.visible=true
		tingle.play()
		
		# Wait one second
		await get_tree().create_timer(1.0).timeout
		
		# Destroy the item in the map
		self.queue_free()


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		player_in_range=true
		body.interaction_ui.visible = true


func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		player_in_range=false
		body.interaction_ui.visible = false
