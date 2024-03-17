extends Node3D

@onready var pause_scene = $PauseMenu
var game_paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	
	if Input.is_action_just_pressed("pause_button"):
		game_paused = !game_paused
		pause_scene.visible = game_paused
		get_tree().paused = game_paused
		pause_scene.pause()
		

	#if Input.is_action_just_released("pause_button"):
	pass
