@tool 
class_name InventoryItem
extends Node2D

@export var item_name: String
@export var item_texture: Texture
@export var item_usages: String

var player_in_range: bool

var scene_path = "res://scenes/inventory_item.tscn"

@onready var icon_sprite : Sprite2D = $Sprite2D

func _ready():
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture

func _process(_delta):
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture
		
	if player_in_range and Input.is_action_pressed("pick_up_item"):
		pick_up_item()

func pick_up_item() -> void:
	var item ={
		"quantity": 1,
		"item_name" : item_name,
		"item_texture": item_texture,
		"item_usages": item_usages,
		"scene_path" : scene_path
	}
	
	if Global.goblin_node:
		Global.add_inventory_item(item)
		self.queue_free()


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		player_in_range=true
		body.interaction_ui.visible = true


func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		player_in_range=false
		body.interaction_ui.visible = false
