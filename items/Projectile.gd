extends Area2D

var speed = 750
var max_distance = 50


func _process(delta):
	position += transform.x * speed * delta


func _on_Projectile_body_entered(body):
	print(body)
	if body.is_in_group('flippable'):
		if body.flipped:
			queue_free()
	if body.is_in_group("enemies"):
		body.queue_free()
	if body.is_in_group("players"):
		body.queue_free()
	if body.is_in_group("walls"):
		queue_free()
