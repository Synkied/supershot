extends Node2D

export (PackedScene) var Enemy
export (PackedScene) var Weapon

onready var items = $Items
onready var player_camera = $Player/Camera2D
onready var player = $Player
var enemies = []
var weapons = []

# Called when the node enters the scene tree for the first time.
func _ready():
	items.hide()
	set_camera_limits()
	spawn_items()


func spawn_items():
	for cell in items.get_used_cells():
		var id = items.get_cellv(cell)
		var type = items.tile_set.tile_get_name(id)
		var pos = items.map_to_world(cell)
		match type:
			'enemy_spawn':
				var enemy = Enemy.instance()
				enemy.position = pos
				add_child(enemy)
				enemies.append(enemy)
			'rifle':
				var weapon = Weapon.instance()
				weapon.init(type, pos)
				add_child(weapon)
				weapon.connect('player_weapon_pickup', player, 'attach_weapon')
				weapons.append(weapon)

	for weapon in weapons:
		for enemy in enemies:
			weapon.connect('enemy_weapon_pickup', enemy, 'attach_weapon')

func set_camera_limits():
	var map_size = $Ground.get_used_rect()
	var cell_size = $Ground.cell_size
	player_camera.limit_left = map_size.position.x * cell_size.x
	player_camera.limit_top = map_size.position.y * cell_size.y
	player_camera.limit_right = map_size.end.x * cell_size.x
	player_camera.limit_bottom = map_size.end.y * cell_size.y
