extends Node2D

const DIRECTIONS = [
	Vector2.ZERO,
	Vector2.RIGHT, 
	Vector2.UP, 
	Vector2.LEFT, 
	Vector2.DOWN
]

export var steps: = 100000
onready var tileMap = $Water
onready var player = $Player
onready var bg = $ParallaxBackground
var borders = Rect2()

func _ready():
	randomize()
	borders = Rect2(Vector2(-6100, -3828), Vector2(14532, 6520))
	generate_level()
	
func generate_level():
	var walker = Walker.new(Vector2(0, 0), borders)
	var map = walker.walk(steps)
	walker.queue_free()
	
	# Set player to first position in generated map
	player.set_position(map[0])
	
	# Generate tiles
	for location in map:
		for direction in DIRECTIONS:
			# Set tile as floor
			tileMap.set_cellv(location+direction, 3)
			
			# Generate invisible collision tiles
			for collision_direction in DIRECTIONS:
				var collision_position = location+direction+collision_direction
				var tile: int = tileMap.get_cellv(collision_position)
				
				if tile == -1: # if it is not floor
					tileMap.set_cellv(collision_position, 9)
					
func get_tilemap_floor():
	return $Water
