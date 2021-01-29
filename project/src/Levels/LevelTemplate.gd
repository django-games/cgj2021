extends Node2D

const DIRECTIONS = [Vector2.ZERO,Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

export var steps: = 100000
onready var tileMap = $Water
onready var player = $Player
var borders = Rect2()

func _ready():
	randomize()
	borders = Rect2(Vector2(-6400, -4128), Vector2(14832, 6820))
	generate_level()
	
func generate_level():
	var walker = Walker.new(Vector2(0, 0), borders)
	var map = walker.walk(steps)
	walker.queue_free()
	player.set_position(map[0])
	for location in map:
		for direction in DIRECTIONS:
			tileMap.set_cellv(location+direction, 3)
