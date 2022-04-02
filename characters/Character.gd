extends KinematicBody2D

signal bullet_shot

# Exposed variables
export (PackedScene) var Bullet
export  (int) var speed = 300
export (float) var friction = 0.8
export (float) var acceleration = 0.1
export (float) var fire_delay = 0.5  # Fire rate 1 bullet per second
export (float) var max_fire_delay = 1

# onready
onready var gun = $Weapon
onready var muzzle = $Weapon/Muzzle
onready var sprite = $AnimatedSprite
var has_weapon = false


func shoot():
	var bullet = Bullet.instance()
	var target = owner
	if target == null:
		target = get_tree().root

	target.add_child(bullet)
	bullet.global_transform = muzzle.global_transform
	fire_delay = max_fire_delay
	$BulletShot.play()
	bullet.connect('game_over', self, 'dead')


func attach_weapon(texture):
	has_weapon = true
	$Weapon/Sprite.texture = load(texture)

