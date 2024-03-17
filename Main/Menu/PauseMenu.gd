extends Node2D



func pause():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$VBoxContainer/Resume.grab_focus()


func _on_button_pressed():
	
	pass


func _on_quit_pressed():
	OS.alert("meow","meow")
	pass
