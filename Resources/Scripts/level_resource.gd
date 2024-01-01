extends Resource
class_name LevelResource

@export var level_name : String
@export var level_scene : PackedScene

var state = {
	"collectables" : {},
	"level_score" : 0,
	"current_checkpoint_name" : null
}
