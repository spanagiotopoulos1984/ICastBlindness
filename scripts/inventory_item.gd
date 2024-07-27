@tool 
class_name InventoryItem
extends Node2D

@export var item_name: String
@export var item_texture: Texture
@export var item_texture_ui: Texture
@export var item_usages: String

var player_in_range: bool

var scene_path = "res://scenes/spell_item.tscn"

@onready var icon_sprite : Sprite2D = $Sprite2D
@onready var pointer_icon : AnimatedSprite2D = $Pointer
@onready var tingle : AnimatedSprite2D = $Tingle

func _ready():
	# At start, set the texture of the item on ground,
	# start the pointer animation and make sure the 
	# tingle animation is not visible.s
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
	var item ={
		"quantity": 1,
		"item_name" : item_name,
		"item_texture": item_texture,
		"item_texture_ui": item_texture_ui,
		"item_usages": item_usages,
		"scene_path" : scene_path
	}
	
	if Global.goblin_node:
		# Add item to inventory
		Global.add_inventory_item(item)
		
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
