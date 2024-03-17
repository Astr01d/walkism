extends Node2D



func pause_unpause():
	var new_pause_state = !get_tree().paused
	get_tree().paused = new_pause_state
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	self.hide()
	pass

func pause():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$VBoxContainer/Resume.grab_focus()


func _on_button_pressed():
	pause_unpause()
