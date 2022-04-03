extends CanvasLayer

# Onready
onready var message = $Message
onready var message_tween = $MessageTween
onready var message_timer = $MessageTimer

# Variables
var base_music = preload('res://assets/base_music.wav')

func _ready():
	play_music()

func process_message(text):
	if message:
		message.text = text
		message.show()
		message_timer.start()

func play_music():
	if !Music.is_playing():
		Music.stream = base_music
		Music.play()

func _on_AudioStreamPlayer_finished():
	play_music()


func _on_Timer_timeout():
	message_tween.interpolate_property(
		message,
		"rect_position",
		Vector2(0, 0),
		Vector2(0, 1000),
		0.3,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)
	message_tween.start()


func _on_MessageTween_tween_completed(_object, _key):
	message.queue_free()
	message_timer.queue_free()
