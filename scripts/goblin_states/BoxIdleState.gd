extends GoblinState

func _ready():
	set_physics_process(false)
	
func enter():
	set_physics_process(true	)
	
func exit():
	set_physics_process(false)
	
func transition():
	pass
	
func _physics_process(_delta):
	transition()
	debug.text = name

func create_trail():
	pass
