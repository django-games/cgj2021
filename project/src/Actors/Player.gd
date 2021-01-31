extends KinematicBody2D

const LAND_TILE = 3

export (int) var DEFAULT_SPEED = 250
export (int) var DASH_SPEED = 800
var speed: int = DEFAULT_SPEED
var velocity = Vector2()
var block_dash = false
var dead: = false
onready var tilemap_floor = get_parent().get_tilemap_floor()
onready var death_message = $DeathMessage
onready var win_message = $WinMessage

var collected_gems = []
const GEMS_TO_WIN = 5

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
	velocity = cartesian_to_isometric(velocity)

func _physics_process(delta):
	if not check_void() and not is_dead():
		get_input()
		velocity = move_and_slide(velocity)
	
	if self.dead:
		self.death_message.percent_visible += 0.01
	elif check_win():
		self.win_message.percent_visible += 0.01
		
func check_void():
	var tile_pos = tilemap_floor.world_to_map(position)
	if not block_dash and tilemap_floor.get_cellv(tile_pos) == -1:
		self.die()
		return true # you die
	return false

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
	# COMENTADO PARA INTENTAR HACERLO LUEGO
	# Verificar que puede llegar al otro lado
	#var position_in_front = position + velocity.normalized() * DASH_SPEED
	#var a = tilemap_floor.world_to_map(tilemap_floor.global_transform.xform_inv(position_in_front))
	#if tilemap_floor.get_cellv(a) == LAND_TILE:
		# Si es tierra, se quita la collision mask 2 que es la de piso
		
	set_collision_mask_bit(1, false)	
	block_dash = true
	speed = DASH_SPEED
	$DashTimer.start()
		

func _on_DashTimer_timeout():
	# Restauramos las configuraciones
	speed = DEFAULT_SPEED
	set_collision_mask_bit(1, true)
	block_dash = false
	

func cartesian_to_isometric(cartesian):
	var screen_pos = Vector2()
	screen_pos.x = cartesian.x - cartesian.y
	screen_pos.y = (cartesian.x + cartesian.y) / 2.0
	return screen_pos

func die():
	if not is_dead() and not check_win():
		get_parent().get_node("SFX/LOST").play()
		$MainMenuTimer.start()
		dead = true
		$Camera2D/Blur.maxOpacity()
	
func is_dead():
	return dead

func pick_gem(gem_name):
	collected_gems.append(gem_name)
	if check_win():
		$MainMenuTimer.start()

func check_win():
	return collected_gems.size() == GEMS_TO_WIN

func _on_MainMenuTimer_timeout():
	if check_win():
		get_tree().change_scene("res://src/UI/Outro.tscn")
	else:
		get_tree().change_scene("res://src/UI/MainMenu.tscn")
