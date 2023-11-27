extends Node

var current_level : Node

func load_level(level):
	current_level.queue_free()
	current_level = load(level).instantiate()
	SceneTrainsition.transition_in()

func exit_level():
	SceneTrainsition.transition_out()
