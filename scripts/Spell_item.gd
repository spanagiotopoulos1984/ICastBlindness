@tool 
class_name SpellItem
extends Node2D

@export var spell_id: int = -1

var player_in_range: bool

var scene_path = "res://scenes/inventory_item.tscn"

@onready var icon_sprite : Sprite2D = $Sprite2D
@onready var pointer_icon : AnimatedSprite2D = $Pointer
@onready var tingle : AnimatedSprite2D = $Tingle

	#spell_id = 0,
	#spell_name = 'I cast BLINDNESS!',
	#spell_description = 'Like throw dirt eyes, but gooder!',
	#spell_ingredients = '1 thingie',
	#aquire_phrase = 'Goodest spell thing! Cheap cheap!',
	#required_ingredients = [1,0,0,0,0,0],
	#cooldown = 2.0,
	#spell_texture = "res://textures/spells/blindness.png"

func _ready():
	# If no spell_id has been set (it is the default -1), destroy the item.
	# So as to avoid bugs. Just print a debug message!
	if spell_id!=-1:
		if not Engine.is_editor_hint():
			icon_sprite.texture = Global.SPELLS[spell_id]['spell_texture']		
			
			pointer_icon.play()
			
			tingle.visible=false
			tingle.stop()
			tingle.frame=0
	else:
		print_debug('Spell has not been set an id!!')
		queue_free()

func _process(_delta):
	if not Engine.is_editor_hint():
		icon_sprite.texture = Global.SPELLS[spell_id]['spell_texture']	
		
	if player_in_range and Input.is_action_pressed("pick_up_item"):
		pick_up_item()

func pick_up_item() -> void:
	var spell_item = Global.SPELLS[spell_id]
	
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
	if body.is_in_group("Player"):
		player_in_range=false
		body.interaction_ui.visible = false
