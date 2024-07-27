@tool 
class_name SpellItem
extends Node2D

@export var spell_id: int

var player_in_range: bool

var scene_path = "res://scenes/spell_item.tscn"

@onready var icon_sprite : Sprite2D = $Sprite2D
@onready var pointer_icon : AnimatedSprite2D = $Pointer
@onready var tingle : AnimatedSprite2D = $Tingle

func _ready():
	 #If no spell_id has been set (it is the default -1), destroy the item.
	 #So as to avoid bugs. Just print a debug message!
	if spell_id != -1 and not Engine.is_editor_hint() :
		print(Global.SPELLS[spell_id]['spell_texture'])
		var texture_path = Global.SPELLS[spell_id]['spell_texture']
		icon_sprite.texture = load(texture_path)
		
		pointer_icon.play()
		
		tingle.visible=false
		tingle.stop()
		tingle.frame=0
	elif spell_id == -1:
		icon_sprite.visible = false

func _physics_process(_delta):
	if spell_id == -1:
		icon_sprite.visible = false
		print_debug('Spell has not been set an id!!')
	else:			
		if player_in_range and Input.is_action_just_pressed("pick_up_item"):
			pick_up_spell()
	

func pick_up_spell() -> void:
	if spell_id != -1:
		if Global.goblin_node:
			# Add item to inventory
			Global.add_spell(spell_id)
			
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
	print("Hello 2!")
	if body.is_in_group("Player"):
		player_in_range=false
		body.interaction_ui.visible = false
