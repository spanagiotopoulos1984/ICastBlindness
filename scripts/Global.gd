extends Node

signal inventory_updated

signal spellbook_updated

const RANDOM_ITEM_PHRASES = ['mine!','I got it!','come here!','muahahahah!','yes!','ohhh look at it!']

# An array to hold inventory items
var inventory = []

const SPELLS = [{
	spell_id = 0,
	spell_name = 'I cast BLINDNESS!',
	spell_description = 'Like throw dirt eyes, but gooder!',
	spell_ingredients = '1 thingie',
	aquire_phrase = 'Goodest spell thing! Cheap cheap!',
	required_ingredients = [1,0,0,0,0,0],
	cooldown = 2.0,
	spell_texture = "res://textures/spells/blindness.png"
},{
	spell_id = 1,
	spell_name = 'BOING!',
	spell_description = 'Dum dum metagnomes go search boing-boing! Not forever.',
	spell_ingredients = '2 thingie',
	aquire_phrase = 'Gnomes dum dum, they go follow this hear thing spell!',
	required_ingredients = [0,1,0,0,0,0],
	cooldown = 1.5,
	spell_texture = "res://textures/spells/boing.png"
},{
	spell_id = 2,
	spell_name = 'FREEZE I say!',
	spell_description = 'Metagnomes become icecream gnomes! For little.',
	aquire_phrase = 'Make them ice cream! Hihihihi',
	spell_ingredients = '3 thingie',
	required_ingredients = [0,0,1,0,0,0],
	cooldown = 5.0,
	spell_texture = "res://textures/spells/freeze.png"
},{
	spell_id = 3,
	spell_name = 'Open Door thing!',
	spell_description = 'Locks cry, I laugh!',
	aquire_phrase = 'No more door things-things!',
	spell_ingredients = '4 Thingies',
	required_ingredients = [0,0,0,1,0,0],
	cooldown = 10.0,
	spell_texture = "res://textures/spells/unlock.png"
},{
	spell_id = 4,
	spell_name = 'Break Magic thing!',
	spell_description = 'Makes magic go bye-bye!',
	aquire_phrase = 'Only I make magic now!',
	spell_ingredients = '5 Thingies',
	required_ingredients = [0,0,0,0,1,0],
	cooldown = 10.0,
	spell_texture = "res://textures/spells/dispell.png"
},{
	spell_id = 5,
	spell_name = 'F I R E B A L L!',
	spell_description = 'HAHAHAHAHAHAHAHAHA',
	aquire_phrase = 'Mine! Mine! Mine! FIREBALL!',
	spell_ingredients = '6 Thingies',
	required_ingredients = [0,0,0,0,0,1],
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

# An array to hold spells
var spellbook = []

# An array to check if a spell has been aquired. There are better solutions,
# but it will suffice for now
var spells_aquired = [false,false,false,false,false,false]

var goblin_node: Goblin  = null		

var rng = RandomNumberGenerator.new()

@onready var inventory_slot_scene :PackedScene = preload("res://scenes/inventory_slot.tscn")

@onready var spellbook_scene :PackedScene = preload("res://scenes/spell_slot.tscn")
	
func _ready():
	inventory.resize(6)
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

	return false
	
func add_inventory_item(item) -> bool:
	var item_name = item['item_name']
	
	var phrase = RANDOM_ITEM_PHRASES[get_random_number()]
	goblin_node.speak(item_name+', '+phrase , 1.5)
	
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

func get_random_number() -> int:
	return rng.randi_range(0, 5)
