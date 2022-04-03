extends CanvasLayer

# Variables
var intro_music = preload("res://assets/intro.wav")

func _ready():
	Engine.time_scale = 1.0
	play_music()
	$TextAnimation.play("appear")
	$BulletAnimation.play("bullets")
	$HighScore.text += str(GlobalStore.highscore)

func _input(event):
	if event.is_action_pressed('ui_select'):
		GlobalStore.new_game()


func _on_Button_pressed():
	GlobalStore.new_game()


func play_music():
	if !$AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.stream = intro_music
		$AudioStreamPlayer.play()

func _on_AudioStreamPlayer_finished():
	play_music()
