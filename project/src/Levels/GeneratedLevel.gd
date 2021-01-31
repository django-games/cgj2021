extends Node2D


export (PackedScene) var Gem

const DIRECTIONS = [
	Vector2.ZERO,
	Vector2.RIGHT,
	Vector2.RIGHT + Vector2.UP,
	Vector2.UP, 
	Vector2.LEFT + Vector2.UP,
	Vector2.LEFT, 
	Vector2.LEFT + Vector2.DOWN,
	Vector2.DOWN,
	Vector2.RIGHT + Vector2.DOWN
]

const GEMS = [
	"dark_gem",
	"magenta_gem",
	"purple_gem",
	"silver_gem",
	"yellow_gem"
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
	player.position = map[0]
	
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
	add_gems(map)


func add_gems(map):
	
	var incr = 3
	var i = incr
	for gem in GEMS:
		# Add objects randomly in the map
		var gem_instance = Gem.instance()
		gem_instance.gem_name = gem

		gem_instance.position = tileMap.map_to_world(map[i])
		
		# Cambiar linea de arriba por lo siguiente cuando querramos randomizar
		# gem_instance.position = tileMap.map_to_world(map[randi() % map.size()])
		add_child(gem_instance)

		i += incr
		

		

func get_tilemap_floor():
	return $Water

func get_player():
	return $Player
