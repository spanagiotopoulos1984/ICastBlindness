class_name GnomeState 
extends State

@export var blinded_state: State
@export var chasing_state: State
@export var frozen_state: State
@export var gnome_idle_state: State
@export var patroling_state: State
@export var return_to_patrol_state: State

var is_detecting_goblin: bool = false

var last_known_posititon: Vector2
var last_patrol_position: Vector2
