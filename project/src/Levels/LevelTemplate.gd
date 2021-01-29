extends Node2D

export var steps: = 1000
onready var tileMap = $Water
onready var player = $Player
var borders = Rect2()

func _ready():
	randomize()
	borders = Rect2(Vector2(0, 0), Vector2(135, 20))
	generate_level()
	
func generate_level():
	var walker = Walker.new(Vector2(0, 0), borders)
	var map = walker.walk(steps)
	walker.queue_free()
	player.set_position(map[0])
	for location in map:
		tileMap.set_cellv(location, 3)
