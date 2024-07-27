class_name SpellSlot
extends Control

@onready var texture_button : TextureButton = $SpellBorder/Spell/TextureButton
@onready var progress_bar: TextureProgressBar = $SpellBorder/Spell/TextureProgressBar
@onready var details_panel: ColorRect = $SpellBorder/DetailsPanel
@onready var spell_cooldown: Timer = $SpellBorder/Spell/SpellCooldown
@onready var cooldown_text: Label = $SpellBorder/Spell/SpellCooldownText
@onready var spell_name: Label = $SpellBorder/DetailsPanel/SpellName
@onready var spell_details = $SpellBorder/DetailsPanel/SpellDetails
@onready var ingredients = $SpellBorder/DetailsPanel/Ingredients

@export var cooldown: float = 2.0
@export var is_spell_found: bool = false

var is_spell_ready: bool = true

# Hold the Spell node
var spell_item = null

func _ready():
	set_process(false)
	progress_bar.visible = false
	progress_bar.max_value = cooldown
	spell_cooldown.stop()
	spell_cooldown.wait_time = cooldown
	
func _process(_delta):
	cooldown_text.text = "%3.1f" % spell_cooldown.time_left
	progress_bar.value = spell_cooldown.time_left

func set_spell(spell:Dictionary) -> void:
	spell_item = spell
	texture_button.texture_norma.texture = spell['spell_texture']
	spell_name.text = spell['spell_name']
	spell_details.text = spell['spell_description']
	ingredients.text = spell['spell_ingredients']

func start_casting():
	is_spell_ready = false
	progress_bar.visible = true
	spell_cooldown.wait_time = cooldown
	spell_cooldown.start()
	set_process(true)

func _on_texture_button_mouse_entered():
	details_panel.visible = true


func _on_texture_button_mouse_exited():
	details_panel.visible = false


func _on_spell_cooldown_timeout():
	pass # Replace with function body.
