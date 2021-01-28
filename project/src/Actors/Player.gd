extends KinematicBody2D

export (int) var speed = 250
var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 2
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 2
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	if Input.is_action_just_pressed('ui_dash'):
		dash()
	animate()
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func animate():
	if velocity.x == 0 and velocity.y == 0:
		$AnimatedSprite.stop()
		return
		
	var x_move = ""
	var y_move = ""
	
	if velocity.x > 0:
		x_move = '_right'
	elif velocity.x < 0:
		x_move = '_left'
		
	if velocity.y > 0:
		y_move = '_back'
	elif velocity.y < 0:
		y_move = '_front'
		
	var move = 'move' + x_move + y_move
	$AnimatedSprite.play(move)

# Dash movement
func dash():
	speed *= 5.0
	$DashTimer.start()

func _on_DashTimer_timeout():
	speed /= 5.0
