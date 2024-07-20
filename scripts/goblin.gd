class_name Goblin
extends AnimatedEntity

# The following vavriables are used by the state machine, so we can change
# easily between states, and interact diferently based on the current node
# state
@onready var state_machine = $GolbinStateMachine

# Ready is called when the node is initialized. The _ in this case means it is
# a pre-built class.
func _ready() -> void:
	state_machine.init(self)

# Used when an input is not consumed by a handler, so it can be propagated to
# the state machine.
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta):
	state_machine.process_physics(delta)

# A signal that is emitted every 2 seconds. It creates a trail of markers,
# that can be used to allow enemies to follow the player, while still allowing
# easy control of player states such as hiding inside the box or being in a 
# shadow area.
func _on_marker_creation_timer_timeout():
	var goblin_state_machine = state_machine as GoblinStateMachine
	goblin_state_machine.create_trail()
