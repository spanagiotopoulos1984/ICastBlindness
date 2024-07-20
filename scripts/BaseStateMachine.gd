class_name BaseStateMachine 
extends Node

@export var starting_state: State
var current_state: State

# This function initializes the state machine, it gives each child node
# (i.e. all the viable states) a referent to the owner it belongs, 
# enters the default starting_state. Using AnimatedEntity custom class
# so I have acess to speed, parent and animation_player
func init(parent: AnimatedEntity) -> void:
	for state in get_children():
		state.parent = parent
	
	# Initialize the default state
	change_state(starting_state)

# Change to a new state. If we are in a previous state,
# first follow its exit logic.
func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
		
	current_state = new_state
	current_state.enter()

func create_trail():
	current_state.create_trail()

