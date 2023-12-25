extends Resource

class_name LevelCollectionResource

@export var level_array : Array[LevelResource]
var next_level_index = 0

func get_current_level():
	return level_array[next_level_index]
