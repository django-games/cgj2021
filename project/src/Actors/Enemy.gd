extends Area2D

onready var player = get_parent().get_player()
var speed := 50
var velocity := Vector2()

func _physics_process(delta):
	
	var player_position: Vector2 = player.position
	
	if position.distance_to(player_position) <= 100:
		touch_player()
	elif position.distance_to(player_position) <= 200:
		speed = 100
	else:
		speed = 50
		
	velocity = position.direction_to(player_position) * speed
	
	position += velocity * delta

func touch_player():
	# Se puede emitir una señal para que se baje la vida del player (?)
	print("TOCADO")
