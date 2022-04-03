extends "res://characters/Character.gd"

# Variables
var velocity = Vector2.ZERO
var font
var dashing = false
var DASH_TIME = 0.1
var dash_acc = 0
var BASE_SPEED = 200

func _ready():
	font = Control.new().get_font("font")


func get_input(delta):
#	acceleration = acceleration
	var input_velocity = Vector2.ZERO

	if Input.is_action_pressed("up"):
		input_velocity.y -= 1
	if Input.is_action_pressed("down"):
		input_velocity.y += 1
	if Input.is_action_pressed("left"):
		input_velocity.x -= 1
	if Input.is_action_pressed("right"):
		input_velocity.x += 2
	if Input.is_action_just_pressed('dash'):
		speed = speed * 3
		if not dashing:
			dashing = true

	if dashing:
		dash_acc += delta
	
		if dash_acc >= DASH_TIME:    
			dashing = false
			dash_acc = 0
			speed = BASE_SPEED

	if Input.is_action_just_pressed('click_left') and has_weapon:
		shoot()

	input_velocity = input_velocity.normalized() * speed

	if input_velocity.length() > 0:
		# accelerate when there's input
		sprite.play("walk")
		sprite.flip_h = velocity.x < 0
		velocity = velocity.linear_interpolate(input_velocity, acceleration)
	else:
		# slow down when there's no input
		sprite.play("idle")
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)


func _physics_process(_delta):
	slow_time()
	velocity = move_and_slide(velocity)

func slow_time():
	if velocity.length():
		Engine.time_scale = 1.0
	else:
		Engine.time_scale = 0.05


func _process(delta):
	get_input(delta)
	position += velocity * delta
	
	var distance = gun.position.length()

	var local_mouse_position = get_local_mouse_position()
	gun.rotation = local_mouse_position.angle()
	gun.position = (Vector2.RIGHT * distance).rotated(gun.rotation)


func _draw():
	draw_string(font, Vector2(20, 0), 'Hey you!')
	update()
