extends Node

# To hold the max array size, in order to avoid needless resizing
const MAX_INVENTORY_SIZE = 12

signal inventory_updated

# An empty array instantiated at the start of the Game, that will hold all of
# our items
var inventory = []

# A variable to hold our player node
var goblin: Goblin = null

# A boolean array that keeps track of which spells we have found the recipes for
# To be used to either display scrolls in the world and play the text/sound
# when they are found (if the appropriate value is false) or to not display them
# at all, but actually display the spells in the action bar.	
var spells_found = [false,false,false,false,false]

func _ready():
	inventory.resize(MAX_INVENTORY_SIZE)

func add_inventory_item(item: InventoryItem) -> bool:
	# Check if we have already the item in the inventory, and increase its
	# quantity
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["item_type"] == item["item_type"]:
			inventory[i]["quantity"] += 1
			inventory_updated.emit()
			return true
		else: 
			inventory.append(item)
			inventory_updated.emit()
			return true
	return false
	
func remove_inventory_item():
	inventory_updated.emit()
	
func increase_inventory_size():
	inventory_updated.emit()
	
func set_goblin(goblin_node :Goblin) -> void:
	goblin = goblin_node	
