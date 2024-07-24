class_name Item
extends Node

var id:int
@export var item_name :String
@export var quantity: int

func consume():
	if quantity>0:
		quantity-=1
	else:
		push_error("Cannot consume item, quantity is not positive.")
		
func pick_up_item(area:Area2D):
	quantity+=1
	area.get_parent().queue_free()
