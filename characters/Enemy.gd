extends "res://characters/Character.gd"


var screensize = Vector2(480, 720)
var original_gun_x
var player = null
var move = Vector2.ZERO
var aiming_angle = 0
var player_position = null

func _ready():
	original_gun_x =  gun.position.x


func _physics_process(delta):
	gun.position.x = original_gun_x
	
	if player != null:
		move = position.direction_to(player.position) * speed  * delta
		if fire_delay < 0 and has_weapon:
			shoot()
		else:
			fire_delay -= 1.0 * delta
	else:
		move = Vector2.ZERO
	move = move_and_collide(move)


func _process(_delta):
	var pos = self.position

	if player != null:
		player_position = player.position
		aiming_angle = (player_position - pos).angle()
		gun.rotation = aiming_angle


func _on_Detection_body_entered(body):
	if body.is_in_group('players'):
		player = body


func _on_Detection_body_exited(body):
	if body.is_in_group('players'):
		player = null

