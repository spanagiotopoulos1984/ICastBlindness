extends Node

signal inventory_updated

signal spellbook_updated()

signal spell_casted(spell_id)

const RANDOM_ITEM_PHRASES = ['mine!','I got it!','come here!','muahahahah!','yes!','ohhh look at it!']

var ITEMS = [{
	item_id = 0,
	item_quantity = 0,
	item_name = 'Toothpick',
	item_texture = "res://textures/ingredients/toothpicks-l.png",
	item_texture_ui = "res://textures/ingredients/toothpicks-h.png",
	item_desc = 'Looks used? Smells not used! I thinks.	'
},{
	item_id = 1,
	item_quantity = 0,
	item_name = 'Bacon',
	item_texture = "res://textures/ingredients/bacon-l.png",
	item_texture_ui = "res://textures/ingredients/bacon-h.png",
	item_desc = 'Sometims yummy, but this old. This spell stuffs.'
},{
	item_id = 2,
	item_quantity = 0,
	item_name = 'Discarded Wrappers',
	item_texture = "res://textures/ingredients/mwrapper-l.png",
	item_texture_ui = "res://textures/ingredients/mwrapper-h.png",
	item_desc = 'Gnomes think this trash, but trash makes some shiny or something.'
},{
	item_id = 3,
	item_quantity = 0,
	item_name = 'Blackshrom',
	item_texture = "res://textures/ingredients/blackshroom-l.png",
	item_texture_ui = "res://textures/ingredients/blackshroom-h.png",
	item_desc = 'Like other shroom, but this black. Very strongs.'
},{
	item_id = 4,
	item_quantity = 0,
	item_name = 'Fighter Tears',
	item_texture = "res://textures/ingredients/ftears-l.png",
	item_texture_ui = "res://textures/ingredients/ftears-h.png",
	item_desc = 'I am Wizboy. Fighters cry. Yes-yes!'
}]

const SPELLS = [{
	spell_id = 0,
	spell_name = 'I cast BLINDNESS!',
	spell_description = 'Like throw dirt eyes, but gooder!',
	spell_ingredients = '1 thingie',
	aquire_phrase = 'Goodest spell thing! Cheap cheap!',
	required_ingredients = [1,0,0,0,0],
	cooldown = 2.0,
	spell_texture = "res://textures/spells/blindness.png"
},{
	spell_id = 1,
	spell_name = 'BOING!',
	spell_description = 'Dum dum metagnomes go search boing-boing! Not forever.',
	spell_ingredients = '2 thingie',
	aquire_phrase = 'Gnomes dum dum, they go follow this hear thing spell!',
	required_ingredients = [0,1,0,0,0],
	cooldown = 1.5,
	spell_texture = "res://textures/spells/boing.png"
},{
	spell_id = 2,
	spell_name = 'FREEZE I say!',
	spell_description = 'Metagnomes become icecream gnomes! For little.',
	aquire_phrase = 'Make them ice cream! Hihihihi',
	spell_ingredients = '3 thingie',
	required_ingredients = [1,1,0,0,0],
	cooldown = 5.0,
	spell_texture = "res://textures/spells/freeze.png"
},{
	spell_id = 3,
	spell_name = 'Open Door thing!',
	spell_description = 'Locks cry, I laugh!',
	aquire_phrase = 'No more door things-things!',
	spell_ingredients = '4 Thingies',
	required_ingredients = [0,1,0,1,0],
	cooldown = 10.0,
	spell_texture = "res://textures/spells/unlock.png"
},{
	spell_id = 4,
	spell_name = 'Break Magic thing!',
	spell_description = 'Makes magic go bye-bye!',
	aquire_phrase = 'Only I make magic now!',
	spell_ingredients = '5 Thingies',
	required_ingredients = [1,1,1,1,0],
	cooldown = 10.0,
	spell_texture = "res://textures/spells/dispell.png"
},{
	spell_id = 5,
	spell_name = 'F I R E B A L L!',
	spell_description = 'HAHAHAHAHAHAHAHAHA',
	aquire_phrase = 'Mine! Mine! Mine! FIREBALL!',
	spell_ingredients = '6 Thingies',
	required_ingredients = [1,1,1,1,1],
	cooldown = 1000.0,
	spell_texture = "res://textures/spells/fireball.png"
}]

const BLANK_SPELL = {
	spell_id = 0,
	spell_name = '?',
	spell_description = 'No spell, dum-dum!',
	spell_ingredients = 'What what?',
	cooldown = 0.0,
	spell_texture = "res://textures/spells/blank-spell.png"
}

const EMPTY_ITEM = {
	item_id = -1,
	item_quantity = 0,
	item_name = 'Pockets! Empty',
	item_texture = "res://textures/ingredients/empty.png",
	item_texture_ui = "res://textures/ingredients/empty.png",
	item_desc = 'Makes pocket feel clean.'
}

# An array to hold inventory items
var inventory = []

# An array to hold spells
var spellbook = []

# An array to check if a spell has been aquired. There are better solutions,
# but it will suffice for now
var spells_aquired = [false,false,false,false,false,false]

var goblin_node: Goblin  = null		

var rng = RandomNumberGenerator.new()

@onready var inventory_slot_scene :PackedScene = preload("res://scenes/inventory_slot.tscn")

@onready var spellbook_scene :PackedScene = preload("res://scenes/spell_slot.tscn")
	
# Running out of time. Quick hack to have one-time pick_up items
@onready var is_backpack_picked: bool = false
	
func _ready():
	inventory.resize(5)
	spellbook.resize(6)
	
	# At the start of the game, we only have empty spells
	for i in range(spellbook.size()):
		spellbook[i] = BLANK_SPELL
		
	
func add_spell(spell_id:int) -> bool:
	var phrase = SPELLS[spell_id]['aquire_phrase']
	goblin_node.speak(phrase , 1.5)
	
	if spells_aquired[spell_id]:
		print_debug("BUG: Got spell that already exists in inventory")
		return false
	else:
		spells_aquired[spell_id] = true
		spellbook[spell_id] = SPELLS[spell_id]
		spellbook_updated.emit()
		return true

func add_inventory_item(item:Dictionary, quantity:int) -> bool:
	var phrase = RANDOM_ITEM_PHRASES[get_random_number()]
	goblin_node.speak(item['item_name']+', '+phrase , 1.5)
	
	# Loop through the array. If you find the item, increase its quantity.
	# If you find null, you reached the end of the array, so the item
	# did not exist at all. Add it.
	for i in range(inventory.size()):
		if inventory[i] and inventory[i]['item_id'] == item['item_id']:
			inventory[i]['item_quantity'] += quantity
			inventory_updated.emit()
			return true
		elif not inventory[i]:
			item['item_quantity'] += quantity
			inventory[i] = item
			inventory_updated.emit()
			return true
	return false
	
func increase_inventory_size() ->void:
	inventory_updated.emit()
	
func set_golbin_reference(goblin: Goblin):
	goblin_node = goblin

# Returns a float from 0.0 to 1.0 inclusive
func get_percentage() -> float:
	return rng.randfn()

# Returns a random int from 0 to RANDOM_ITEM_PHRASES size inclusive
func get_random_number() -> int:
	return rng.randi_range(0, RANDOM_ITEM_PHRASES.size()-1)

func check_spell_ingredients(spell_id: int) -> bool:
	# Get the ingredient array
	var required_ingredients = SPELLS[spell_id]['required_ingredients']
	
	var required_ingredients_check = [false,false,false,false,false]
	
	# Now let's check the inventory to see if we have them all! Remember
	# to also remove them, if we do have them all.
	for i in range(required_ingredients.size()):
		var required_quantity = required_ingredients[i]
		if required_quantity == 0:
			required_ingredients_check[i] = false
		elif required_quantity > 0:
			
			var ingredient_found = false
			
			for j in range(inventory.size()):
				var item = inventory[j]
				print(item)
				# If an item is missing, or we don't have enough quantity,
				# immediately return false. There is no sense in checking the
				# rest
				if item != null and item['item_id'] == i :
					print(item['item_name'],':',item['item_quantity'])
					if item['item_quantity'] > 0 and item['item_quantity'] >= required_quantity:
						required_ingredients_check[i] = true
						ingredient_found = true
					else:
						return false
					
			if not ingredient_found:
				return false

	# If we are here, we have ALL required ingredients.
	for i in range(required_ingredients_check.size()):
		if required_ingredients_check[i]:
			var required_quantity = required_ingredients[i]
			inventory[i]['item_quantity'] -= required_quantity
			
	# Update the inventory!
	inventory_updated.emit()		
	return true
	
