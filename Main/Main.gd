extends Node3D


var Levels = {
	"test_level" : "res://Misc/Scenes/test_level.tscn",
	"test_spire" : "res://Misc/Scenes/test_spire_land.tscn"
	}

var current_save
var player_data
var player_scene
var player_name = "Player"

#gonna see if its useful to use one class for the tracking of player data n shit
class PlayerData:
	var current_level
	var player_transform
	var player_stats
	var player_inventory
	var story_flags
	
	func _init():
		player_transform = Transform3D()
		current_level = ""
		player_stats = []
		player_inventory = []
		story_flags = []
	
	pass



func _ready():
	player_data = PlayerData.new()
	
	player_data.current_level = "test_spire"
	pass


func setup_player():
	
	var loaded_player_scene = load("res://Main/Player.tscn")
	player_scene = loaded_player_scene.instantiate()
	
	player_scene.name = player_name
	
	player_scene.transform = player_data.player_transform
	
	self.add_child(player_scene)
	pass


func load_level(level):
	var loaded_level_scene = load(Levels[level])
	var level_scene = loaded_level_scene.instantiate()
	
#	this assumes we dont want level pooling which means we 
#	need a flag system which we need anyway which kinda sucks but ok 
	
	if $Level.get_child_count() > 0:
		var loaded_levels = $Level.get_children(true)
		for i in range(loaded_levels.size()):
			loaded_levels[i].queue_free()
	else:
		pass
	
	$Level.add_child(level_scene)
	pass

func warp_player(target_level, player_transform):
	load_level(target_level)
	
	pass
	
func _process(delta):
	pass
