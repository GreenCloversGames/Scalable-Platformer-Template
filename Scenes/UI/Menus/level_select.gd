extends Control

@onready var grid = %LevelGrid

@onready var level_selector_scene : PackedScene = preload("res://Scenes/UI/PArts/level_selector.tscn")

signal level_selected(level)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func add_level(level:LevelResource):
	var selector := level_selector_scene.instantiate()
	grid.add_child(selector)
	selector.level_name = level.level_name
	var signal_emit_callable = emit_level_selected.bind(level)
	selector.button.pressed.connect(signal_emit_callable)

func add_all_levels(level_res:LevelCollectionResource):
	for level in level_res.level_array:
		add_level(level)

func emit_level_selected(level):
	level_selected.emit(level)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
