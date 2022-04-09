extends CanvasLayer

# Variables
var intro_music = preload("res://assets/intro.wav")

func _ready():
	Engine.time_scale = 1.0
	Music.stop()
	play_music()
	$TextAnimation.play("appear")
	$BulletAnimation.play("bullets")
	$HighScore.text += str(GlobalStore.highscore)

func _input(_event):
	if Input.is_action_just_pressed('continue'):
		GlobalStore.continue_game()
	if Input.is_action_just_pressed('restart'):
		GlobalStore.new_game()

func play_music():
	if !$AudioStreamPlayer.is_playing():
		$AudioStreamPlayer.stream = intro_music
		$AudioStreamPlayer.play()

func _on_AudioStreamPlayer_finished():
	play_music()


func _on_RestartButton_pressed():
	GlobalStore.new_game()


func _on_ContinueButton_pressed():
	GlobalStore.continue_game()
