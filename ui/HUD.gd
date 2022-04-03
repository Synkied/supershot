extends CanvasLayer

## Variables
var base_music = preload('res://assets/base_music.wav')

func _ready():
	play_music()

func play_music():
	if !Music.is_playing():
		Music.stream = base_music
		Music.play()

func _on_AudioStreamPlayer_finished():
	play_music()
