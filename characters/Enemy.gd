extends "res://characters/Character.gd"

# Exports
export (float) var detection_radius = 400

# Variables
var screensize = Vector2(480, 720)
var player = null
var move = Vector2.ZERO
var aiming_angle = 0
var player_position = null


func _ready():
	$Detection/CollisionShape2D.shape.radius = detection_radius
	can_shoot = false
	yield(get_tree().create_timer(0.01), 'timeout')
	can_shoot = true

func _physics_process(delta):
	move = Vector2.ZERO
	
	if player != null:
		var space_state = get_world_2d().direct_space_state
		var collider = space_state.intersect_ray(position, player.position)
		if collider:
			var collider_name = collider.collider.name
			if collider_name == 'Walls':
				move = Vector2.ZERO
			else:
				move = position.direction_to(player.position) * speed  * delta
				sprite.play("walk")
				if fire_delay < 0 and has_weapon and can_shoot:
					shoot()
				else:
					fire_delay -= 1.0 * delta

	else:
		move = Vector2.ZERO
		sprite.play("idle")

	move = move_and_collide(move)


func _process(_delta):
	if player != null:
		var distance = gun.position.length()
		player_position = player.position
		aiming_angle = (player_position - position).angle()
		gun.rotation = aiming_angle
		gun.position = (Vector2.RIGHT * distance).rotated(gun.rotation)


func _on_Detection_body_entered(body):
	if body.is_in_group('players'):
		player = body


func _on_Detection_body_exited(body):
	if body.is_in_group('players'):
		player = null

