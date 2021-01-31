extends Area2D

onready var player = get_parent().get_player()
var speed := 125
var velocity := Vector2()

var particles_threshold_speed = 1

func _physics_process(delta):
	
	var player_position: Vector2 = player.position
	
	if position.distance_to(player_position) <= 200:
		speed = 175
	else:
		speed = 125
		
	velocity = position.direction_to(player_position) * speed
	animate()
	position += velocity * delta
	
	
	$Particles2D.gravity.x = - velocity.x
	$Particles2D.gravity.y = - velocity.y
	
func touch_player():
	# Se puede emitir una señal para que se baje la vida del player (?)
	player.die()


func animate():
	if velocity.x == 0 and velocity.y == 0:
		$AnimatedSprite.stop()
		return
		
	var x_move = ""
	var y_move = ""
	
	if velocity.x > 0 and velocity.x > abs(velocity.y):
		x_move = '_right'
	elif velocity.x < 0 and abs(velocity.x) > abs(velocity.y):
		x_move = '_left'
		
	if velocity.y > 0 and velocity.y > abs(velocity.x):
		y_move = '_back'
	elif velocity.y < 0 and abs(velocity.y) > abs(velocity.x):
		y_move = '_front'
		
	var move = 'move' + x_move + y_move
	$AnimatedSprite.play(move)

func _on_Enemy_body_entered(body):
	body.die() # Replace with function body.
