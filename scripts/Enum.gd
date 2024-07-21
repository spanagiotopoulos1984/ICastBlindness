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
	NONE,
	SOUND,
	BLINDNESS,
	FREEZE,
	UNLOCK
}
