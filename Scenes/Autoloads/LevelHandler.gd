extends Node

var current_level : Node
var next_level_path

func load_level(level_path):
	current_level.queue_free()
	current_level = load(level_path).instantiate()
	SceneTrainsition.transition_in()

func exit_level():
	SceneTrainsition.transition_out()
	await SceneTrainsition.transition_ended
	
