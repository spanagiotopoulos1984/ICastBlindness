extends Camera2D

@export var tilemap: TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	# This returns a rectangle that contains all the used tiles in all layers
	var map_rect = tilemap.get_used_rect()
	
	# This is the width and height of aall the tiles in the map
	var tile_size = tilemap.rendering_quadrant_size
	
	# This now can be used to get the total size of our world
	var world_size_in_pixels = map_rect.size * tile_size
	
	limit_top = 0
	limit_left = 0
	limit_right = world_size_in_pixels.x
	limit_bottom = world_size_in_pixels.y
	
	print(limit_top,",", limit_left,",",limit_right,",",limit_bottom)
	print(map_rect)
	
