extends Node2D



func pause_menu_setup():
	#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$VBoxContainer/Resume.grab_focus()


func _on_button_pressed():
	$"..".pause_unpause()
	pass


func _on_quit_pressed():
	OS.alert("meow","meow")
	get_tree().quit()
	pass
