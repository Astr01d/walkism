extends Node


func _ready():
	$MainMenu.show()
	$"..".load_level("test",Vector3(0,1,0),false)
	pass


func _on_start_continue_pressed():
	$"..".load_level($"..".current_save.current_level,Vector3(0,1,0),true)
	$MainMenu.hide()
	
