extends KinematicBody2D

# Exposed variables
export (PackedScene) var Bullet
export  (int) var speed = 300
export (float) var friction = 0.8
export (float) var acceleration = 0.1
export (float) var fire_delay = 0.5
export (float) var max_fire_delay = 1
export (bool) var can_shoot = true

# onready
onready var gun = $Weapon
onready var muzzle = $Weapon/Muzzle
onready var sprite = $AnimatedSprite
onready var bleeding_timer = $BleedingTimer
onready var bullet_shot_sound: AudioStreamPlayer = $BulletShot
var has_weapon = false


func shoot():
	var bullet = Bullet.instance()
	var target = owner
	if target == null:
		target = get_tree().root

	target.add_child(bullet)
	bullet.global_transform = muzzle.global_transform
	fire_delay = max_fire_delay
	bullet_shot_sound.pitch_scale = rand_range(0.5, 1.5)
	bullet_shot_sound.play()


func bleed():
	can_shoot = false
	$Bleeding.set_deferred('emitting', true)
	$Tween.interpolate_property(
		$AnimatedSprite,
		'modulate',
		Color(1, 1, 1, 1),
		Color(139, 0, 0, 1),
		0.5,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)

	bleeding_timer.start()
	$Tween.start()

func attach_weapon(texture):
	has_weapon = true
	$Weapon/Sprite.texture = load(texture)


func _on_BleedingTimer_timeout():
	queue_free()
