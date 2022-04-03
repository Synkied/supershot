extends Node

# Variables
var levels = [
	'res://levels/Level1.tscn',
	'res://levels/Level2.tscn',
	'res://levels/Level3.tscn',
	'res://levels/Level4.tscn',
	'res://levels/Level5.tscn',
	'res://levels/Level6.tscn',
	'res://levels/Level7.tscn',
	'res://levels/Level8.tscn',
	'res://levels/Level9.tscn',
#	'res://levels/Level10.tscn',
	'res://ui/Win.tscn',
]
var current_level = 0
var start_screen = 'res://ui/StartScreen.tscn'
var end_screen = 'res://ui/EndScreen.tscn'
var score = 0
var highscore = 0
var score_file = "user://highscore.txt"

func _ready():
	setup()

func setup():
	var f = File.new()

	if f.file_exists(score_file):
		f.open(score_file, File.READ)
		var content = f.get_as_text()
		highscore = int(content)
		f.close()


func new_game():
	current_level = -1
	score = 0
	next_level()


func save_score():
	var f = File.new()
	f.open(score_file, File.WRITE)
	f.store_string(str(0))
	f.close()


func game_over():
	if score > highscore: highscore = score
	save_score()
	Engine.time_scale = 1.0
	get_tree().change_scene(end_screen)

func next_level():
	Engine.time_scale = 1.0
	current_level += 1
	if current_level >= GlobalStore.levels.size():
		# no more levels to load :(
		game_over()
	else:
		score += 1
		get_tree().change_scene(levels[current_level])

