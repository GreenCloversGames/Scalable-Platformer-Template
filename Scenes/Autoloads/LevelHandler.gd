extends Node

var current_level : Node

var current_level_index := -1

var next_level_path 

@export var levels : Array[LevelResource]

func load_level(level_path):
	get_tree().change_scene_to_file(level_path)
	SceneTrainsition.transition_out()
	
func exit_level():
	SceneTrainsition.transition_in()
	await SceneTrainsition.transition_ended
	load_level(next_level_path)
