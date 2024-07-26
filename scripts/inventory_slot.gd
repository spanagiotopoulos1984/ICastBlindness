class_name InventorySlot
extends Control

@onready var item_icon = $OuterBorder/ItemIcon
@onready var item_quantity = $OuterBorder/ItemQuantity
@onready var item_name = $OuterBorder/DetailsPanel/ItemName
@onready var item_usages = $OuterBorder/DetailsPanel/ItemUsage
@onready var details_panel = $OuterBorder/DetailsPanel

# Hold the Item node
var item = null

func _on_button_mouse_entered() -> void:
	if item:
		details_panel.visible = true

func _on_button_mouse_exited() -> void:
	details_panel.visible = false

func set_empty() -> void:
	item_name.text = ''
	item_icon.texture = null
	item_quantity.text = ''
	item_usages.text = ''

func set_item(inventory_item) -> void:
	item = inventory_item
	item_name.text = inventory_item['item_name']
	item_icon.texture = inventory_item['item_texture']
	item_quantity.text = str(inventory_item['quantity'])
	item_usages.text = str(inventory_item['item_usages'])
	
