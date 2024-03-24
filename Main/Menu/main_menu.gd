extends Control


func _ready():
	start()
	pass

func start():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$StartContinue.grab_focus()
	$MainMenuRig/MainMenuCam.set_current(true)

func _process(delta):
	
	$MainMenuRig.rotate_y(.001)

	pass 
