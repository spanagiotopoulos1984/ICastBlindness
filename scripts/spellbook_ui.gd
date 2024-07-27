class_name SpellbookUI
extends Control

@onready var horizontal_container = $"."

func _ready():
	Global.spellbook_updated.connect(_on_spellbook_updated)
	initialize()

func initialize():
	clear_container()
	for i in range(Global.spellbook.size()):
		var slot = Global.spellbook_scene.instantiate()
		horizontal_container.add_child(slot)
		slot.set_spell(Global.BLANK_SPELL)

func _on_spellbook_updated(new_spell_id:int):
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
