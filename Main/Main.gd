extends Node3D


var Levels = {
	"test" : "res://Misc/Scenes/test_level.tscn"
	}

var current_save


class game_save:
	var current_level
	
	func _init(level):
		current_level = level
		pass
	
	pass


func _ready():
	current_save = game_save.new("test")
	pass



func load_level(level, spawn_pos, need_player):
	var loaded_level_scene = load(Levels[level])
	var level_scene = loaded_level_scene.instantiate()
	var player_scene
	
	if need_player:
		var loaded_player_scene = load("res://Main/player.tscn")
		player_scene = loaded_player_scene.instantiate()
		player_scene.position = spawn_pos
	
#	this assumes we dont want level pooling which means we 
#	need a flag system which we need anyway which kinda sucks but ok 
	
	if $Level.get_child_count() > 0:
		var loaded_levels = $Level.get_children(true)
		for i in range(loaded_levels.size()):
			loaded_levels[i].queue_free()
	else:
		pass
	
	
	$Level.add_child(level_scene)
	
	add_child(player_scene)
	pass



func _process(delta):
	pass
