extends Node


var game_paused = false

func _ready():
	$MainMenu.show()
	$"..".load_level("test",Vector3(0,1,0),false)
	pass

#pause shit
func _process(delta):
	
	if Input.is_action_just_pressed("pause_button") && !$MainMenu.visible:
		pause_unpause()
		pass

func pause_unpause():
		game_paused = !game_paused
		print(game_paused)
		$PauseMenu.visible = game_paused
		get_tree().paused = game_paused
		$PauseMenu.pause_menu_setup()
		
		if game_paused:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		

func _on_start_continue_pressed():
	$"..".load_level($"..".current_save.current_level,Vector3(0,1,0),true)
	$MainMenu.hide()
	
