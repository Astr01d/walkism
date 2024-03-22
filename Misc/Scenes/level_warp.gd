extends Node3D

@export var target_level : String
@export var target_position : String

var main_scene 

func _ready():
	main_scene = get_tree().root.get_child(0)
	pass


func _on_body_entered(body):
	
	if body.name == main_scene.player_name:
		
		var player_y_angle = body.transform.basis.get_rotation_quaternion().y
		player_y_angle += self.transform.basis.get_rotation_quaternion().y
		main_scene.warp_player(target_level, target_position, player_y_angle)
		pass
	pass # Replace with function body.
