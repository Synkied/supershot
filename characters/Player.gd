extends "res://characters/Character.gd"

# Variables
var velocity = Vector2.ZERO
var font
var original_gun_x


func _ready():
	font = Control.new().get_font("font")
	original_gun_x =  gun.position.x


func get_input():
	var input_velocity = Vector2.ZERO

	if Input.is_action_pressed("up"):
		input_velocity.y -= 1
	if Input.is_action_pressed("down"):
		input_velocity.y += 1
	if Input.is_action_pressed("left"):
		input_velocity.x -= 1
	if Input.is_action_pressed("right"):
		input_velocity.x += 1
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
	gun.position.x = original_gun_x
	get_input()
	slow_time()

	velocity = move_and_slide(velocity)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider_name = collision.collider.name
		print("player collided with ", collision.collider.name)

func slow_time():
	if velocity.length():
		Engine.time_scale = 1.0
	else:
		Engine.time_scale = 0.05
   

func _process(delta):
	get_input()
	position += velocity * delta

	var local_mouse_position = get_local_mouse_position()
	gun.rotation = local_mouse_position.angle()


func _draw():
	draw_string(font, Vector2(20, 0), 'Hey you!')
	update()
