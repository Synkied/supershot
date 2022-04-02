extends Node2D

# Signals
signal player_weapon_pickup
signal enemy_weapon_pickup

# Variables
var type
var textures = {
	'rifle': 'res://assets/rifle.png',
}

func init(_type, pos):
	$Sprite.texture = load(textures[_type])
	type = _type
	position = pos

func enemy_pickup():
	match type:
		'rifle':
			emit_signal('enemy_weapon_pickup', textures[type])
	$Tween.start()


func player_pickup():
	match type:
		'rifle':
			emit_signal('player_weapon_pickup', textures[type])
	$Tween.start()

func _on_Weapon_body_entered(body):
	if body.is_in_group('players'):
		player_pickup()
	if body.is_in_group('enemies'):
		enemy_pickup()


func _on_Weapon_player_weapon_pickup(_texture):
	queue_free()


func _on_Weapon_enemy_weapon_pickup(_texture):
	queue_free()
