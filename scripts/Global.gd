extends Node

# An array to hold inventory items
var inventory = []

signal inventory_updated

var goblin_node: Goblin  = null		

@onready var inventory_slot_scene :PackedScene = preload("res://scenes/inventory_slot.tscn")
	
func _ready():
	inventory.resize(6)
	
func add_inventory_item(item) -> bool:
	var item_name = item['item_name']
	
	# Loop through the array. If you find the item, increase its quantity.
	# If you find null, you reached the end of the array, so the item
	# did not exist at all. Add it.
	for i in range(inventory.size()):
		if inventory[i] and inventory[i]['item_name'] == item_name:
			inventory[i]['quantity'] += 1
			inventory_updated.emit()
			return true
		elif not  inventory[i]:
			inventory[i] = item
			inventory_updated.emit()
			return true
	return false
	
func increase_inventory_size() ->void:
	inventory_updated.emit()
	
func set_golbin_reference(goblin: Goblin):
	goblin_node = goblin
