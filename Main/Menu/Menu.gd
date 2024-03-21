extends Node


var game_paused = false
@onready var main_scene = $".."

func _ready():
	$MainMenu.show()
	main_scene.load_level("test_level")
	pass

func return_to_main_menu():
	if main_scene.player_scene != null:
		main_scene.player_scene.free()
	$MainMenu.show()
	$MainMenu.start()
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
#	replace with start game function later
	main_scene.setup_player()
	main_scene.load_level("test_spire")
	$MainMenu.hide()
	
