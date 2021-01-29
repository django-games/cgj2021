extends KinematicBody2D

const LAND_TILE = 3

export (int) var DEFAULT_SPEED = 250
export (int) var DASH_SPEED = 1000
var speed: int = DEFAULT_SPEED
var velocity = Vector2()
var block_dash = false
onready var tilemap_floor = get_parent().get_tilemap_floor()

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
	if Input.is_action_just_pressed('ui_dash') and not block_dash:
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
	
	if speed > DEFAULT_SPEED:
		$AnimatedSprite.set_speed_scale(4.0)
	else:
		$AnimatedSprite.set_speed_scale(1.0)

# Dash movement
func dash():
	# Verificar que puede llegar al otro lado
	var position_in_front = position + velocity.normalized() * 200
	var a = tilemap_floor.world_to_map(tilemap_floor.global_transform.xform_inv(position_in_front))
	if tilemap_floor.get_cellv(a) == LAND_TILE:
		# Si es tierra, se quita la collision mask 2 que es la de piso
		set_collision_mask_bit(1,false)
	block_dash = true
	speed = DASH_SPEED
	$DashTimer.start()
		

func _on_DashTimer_timeout():
	# Restauramos las configuraciones
	speed = DEFAULT_SPEED
	set_collision_mask_bit(1,true)
	block_dash = false
	
