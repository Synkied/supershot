extends Node2D

# Exports
export (PackedScene) var Enemy
export (PackedScene) var Weapon
export (PackedScene) var Table

# Onready
onready var items = $Items
onready var ground = $Ground
onready var player_camera = $Player/Camera2D
onready var player = $Player
onready var hud = $HUD
onready var message = $Message

# Variables
var enemies = []
var weapons = []
var enemies_dead = false

func _process(_delta):
	are_enemies_dead()

# Called when the node enters the scene tree for the first time.
func _ready():
	items.hide()
	set_camera_limits()
	spawn_items()
	if message:
		hud.process_message(message.text)


func spawn_items():
	for cell_position in items.get_used_cells():
		var cell_rotation = get_cell_rotation(items, cell_position)
		var id = items.get_cellv(cell_position)
		var type = items.tile_set.tile_get_name(id)
		var pos = items.map_to_world(cell_position) + items.cell_size / 2

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
			'table_unflipped', 'table_flipped':
				var table = Table.instance()
				table.init(type, pos, cell_rotation)
				add_child(table)

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


func are_enemies_dead():
	if get_tree().get_nodes_in_group("enemies").empty():
		GlobalStore.next_level()

func next_level():
	GlobalStore.next_level()


func get_cell_rotation(tilemap, cell_position):
	var transposed = tilemap.is_cell_transposed(cell_position.x, cell_position.y)
	var flipX = tilemap.is_cell_x_flipped(cell_position.x, cell_position.y)
	var flipY = tilemap.is_cell_y_flipped(cell_position.x, cell_position.y)

	if (!transposed && !flipX && !flipY):
		return 0

	if (transposed && !flipX && flipY):
		return PI / 2

	if (!transposed && flipX):
		return PI

	if (transposed && flipX && !flipY):
		return PI / 2

	print("Unknown", transposed, flipX, flipY)
	return 0

