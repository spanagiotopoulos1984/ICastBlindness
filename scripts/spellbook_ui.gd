class_name SpellbookUI
extends Control

@onready var horizontal_container = $"."

func _ready():
	pass
	#Global.spellbook_updated.connect(_on_spellbook_updated)
	#_on_spellbook_updated()

func _on_spellbook_updated():
	pass
	#print('I am updating the spellbook!')
	#for i in range(Global.spells_aquired):
		#if Global.spells_aquired[i]:
			#horizontal_container.add_child(Global.SPELLS[i])

		#var slot = Global.spellbook_scene.instantiate()
		#horizontal_container.add_child(slot)
		#if item:
			#slot.set_item(item)
		#else:
			#slot.set_empty()
		
