extends Node

# An enum used to make certain no spelling mistakes introduce a bug in
# the direction variable
enum Direction{
	UP,
	DOWN,
	LEFT,
	RIGHT,
	UP_LEFT,
	UP_RIGHT,
	DOWN_LEFT,
	DOWN_RIGHT
}
enum CASTABLE_SPELL{
	NONE = -1,
	BLINDNESS = 0,
	SOUND = 1,
	FREEZE = 2,
	UNLOCK = 3,
	DISPELL = 4,
	FIREBALL = 5
}
