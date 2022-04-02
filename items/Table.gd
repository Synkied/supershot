extends RigidBody2D

# Onready
onready var sprite = $Sprite

# Variables
var flipped_texture = 'res://assets/table_flipped.png'
export (bool) var flipped = false
export (bool) var flipping = false


func process_flip():
	if flipping:
		sprite.texture = load(flipped_texture)
		var collisions = get_colliding_bodies()
		if not flipped:
			for col_body in collisions:
				sprite.flip_h = col_body.position > self.position
			flipped = true

	flipping = false

func _process(delta):
	process_flip()


func _on_Table_body_entered(body):
	print('table collided with', body)
	if body.is_in_group('players'):
		flipping = true

