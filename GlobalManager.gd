extends Node

# Variables
var levels = [
	'res://levels/Level1.tscn',
	'res://levels/Level2.tscn',
	'res://levels/Level3.tscn',
]
var current_level = 0
var start_screen = 'res://ui/StartScreen.tscn'
var end_screen = 'res://ui/EndScreen.tscn'
var score = 0
var highscore = 0
var score_file = "user://highscore.txt"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func new_game():
	current_level = -1
	score = 0
	next_level()


func save_score():
	var f = File.new()
	f.open(score_file, File.WRITE)
	f.store_string(str(highscore))
	f.close()


func game_over():
	if score > highscore: highscore = score
	save_score()
	get_tree().change_scene(end_screen)

func next_level():
	current_level += 1
	if current_level >= GlobalManager.levels.size():
		# no more levels to load :(
		game_over()
	else:
		get_tree().change_scene(levels[current_level])
