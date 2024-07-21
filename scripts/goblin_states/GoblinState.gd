class_name GoblinState 
extends State

const ENUM = preload("res://scripts/Enum.gd")
const DIRECTION = ENUM.Direction
const CASTABLE = ENUM.CASTABLE_SPELL

@export var casting_state: State
@export var moving_state: State
@export var idle_state: State
@export var hiding_idle_state: State
@export var hiding_moving_state: State
@export var box_idle_state: State
@export var box_moving_state: State

# Preload allows us to 	preload() load a resource when the game starts, 
# before any scripts are run. This can be useful for resources that will be used
# immediately and frequently throughout your game to eliminate delays caused by 
# loading them on-demand.
@onready var goblin_marker = preload("res://scenes/goblin_marker.tscn")

@onready var blindness_spell = preload("res://scenes/BlindnessSpellProjective.tscn")

@onready var freeze_spell = preload("res://scenes/FreezeTrapSpell.tscn")

func create_trail():
	pass
