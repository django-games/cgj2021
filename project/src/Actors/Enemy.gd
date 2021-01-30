extends Area2D

onready var player = get_parent().get_player()
var speed := 200
var velocity := Vector2()

func _physics_process(delta):
	
	var player_position: Vector2 = player.position
	
	if position.distance_to(player_position) <= 200:
		speed = 220
	else:
		speed = 200
		
	velocity = position.direction_to(player_position) * speed
	animate()
	position += velocity * delta

func touch_player():
	# Se puede emitir una señal para que se baje la vida del player (?)
	player.die()


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


func _on_PlayerDetector_body_entered(body):
	body.die()
