extends Node
class_name Walker

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]
const MAX_STEPS: = 50
const CHANCE_TURN: = 0.128

var position: = Vector2.ZERO
var direction: = Vector2.RIGHT
var borders: = Rect2()
var step_history: = []
var steps_since_turn: = 0

func _init(starting_position, new_borders):
	assert(new_borders.has_point(starting_position))
	position = starting_position
	step_history.append(position)
	borders = new_borders
	
	
func walk(steps):
	for step in steps:
		# 100*CHANCE_TURN% change of changing direction before MAX_STEPS steps
		if randf() <= CHANCE_TURN or steps_since_turn >= MAX_STEPS:
			change_direction()
			
		if step():
			step_history.append(position)
		else:
			change_direction()
			
	return step_history
	
func step():
	var target_position: = position + direction
	if borders.has_point(target_position):
		steps_since_turn += 1
		position = target_position
		return true
	else:
		return false
	
func change_direction():
	steps_since_turn = 0
	
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	
	direction = directions.pop_front()
	while not borders.has_point(position+direction):
		direction = directions.pop_front()
	
