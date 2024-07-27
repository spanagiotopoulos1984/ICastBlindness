class_name InventoryUI
extends Control

@onready var horizontal_container = $"."

func _ready():
	Global.inventory_updated.connect(_on_inventory_updated)
	_on_inventory_updated()

func _on_inventory_updated():
	clear_container()
	for item in Global.inventory:
		var slot = Global.inventory_slot_scene.instantiate()
		horizontal_container.add_child(slot)
		if item:
			slot.set_item(item)
		else:
			slot.set_empty()
	
func clear_container():
	for i in range(horizontal_container.get_child_count()):
		var child = horizontal_container.get_child(0)
		horizontal_container.remove_child(child)
		if child:
			child.queue_free()
		
