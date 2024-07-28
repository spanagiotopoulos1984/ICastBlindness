class_name SpellbookUI
extends Control

const ENUM = preload("res://scripts/Enum.gd")
const CASTABLE = ENUM.CASTABLE_SPELL

@onready var horizontal_container = $"."

func _ready():
	Global.spellbook_updated.connect(_on_spellbook_updated)
	Global.spell_casted.connect(_on_spell_cast)
	_on_spellbook_updated()

func _on_spellbook_updated():
	clear_container()
	for i in range(Global.spellbook.size()):
		var spell = Global.BLANK_SPELL
		if Global.spells_aquired[i]:
			spell = Global.SPELLS[i]
		var slot = Global.spellbook_scene.instantiate()
		horizontal_container.add_child(slot)
		slot.set_spell(spell)
	
func clear_container():
	for i in range(horizontal_container.get_child_count()):
		var child = horizontal_container.get_child(0)
		horizontal_container.remove_child(child)
		if child:
			child.queue_free()

# Run out of time. No spell CDs :(
func _on_spell_cast(_spell: CASTABLE):
	#var spell_slot = horizontal_container.get_child(_spell)
	pass
