extends CanvasLayer


func _ready():
	$AnimationPlayer.play("appear")

func _input(event):
	if event.is_action_pressed('ui_select'):
		GlobalManager.new_game()
