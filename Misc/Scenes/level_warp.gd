extends Area3D

@export var target_level : String
@export var warp_position : Transform3D

var main_scene 

func _ready():
	main_scene = get_tree().root.get_child(0)
	print(main_scene.name)
	pass


func _on_body_entered(body):
	print(body.name)
	if body.name == main_scene.player_name:
		main_scene.warp_player(target_level, warp_position)
		pass
	pass # Replace with function body.
