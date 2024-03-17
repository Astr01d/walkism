extends Control


func _ready():
	$MainMenuRig/MainMenuCam.set_current(true)
	pass


func _process(delta):
	
	$MainMenuRig.rotate_y(.01)

	pass 
