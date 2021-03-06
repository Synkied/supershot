extends RigidBody2D

# Onready
onready var sprite = $Sprite
onready var collision_shape = $CollisionShape2D

# Variables
var type
var textures = {
	'table_unflipped': 'res://assets/table_unflipped.png',
	'table_flipped': 'res://assets/table_flipped.png'
}
export (bool) var flipped = false
export (bool) var flipping = false


func init(_type, pos, cell_rotation):
	$Sprite.texture = load(textures[_type])
	type = _type
	position = pos
	rotation = cell_rotation

func process_flip():
	if flipping:
		sprite.texture = load(textures['table_flipped'])
		var collisions = get_colliding_bodies()
		if not flipped:
			for col_body in collisions:
				sprite.flip_h = col_body.position > self.position
			flipped = true

	flipping = false

func _process(_delta):
	process_flip()


func _on_Table_body_entered(body):
	if body.is_in_group('players'):
		flipping = true

