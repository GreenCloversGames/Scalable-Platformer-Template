extends Node

var current_scene : Node

@onready var level_select_scene = preload("res://Scenes/UI/Menus/level_select.tscn")

@onready var levels = preload("res://Resources/level_collection.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	change_to_level_selection()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_scene(new_parent: Node, new_child: Node):
	if current_scene:
		current_scene.queue_free()
	new_parent.add_child(new_child)
	current_scene = new_child

func change_to_level(new_level: LevelResource):
	var level_to_load : PackedScene = new_level.level_scene 
	change_scene($LevelHolder, level_to_load.instantiate())

func change_to_menu(new_menu_scene: Node):
	change_scene($MenuHolder, new_menu_scene)

func change_to_level_selection():
	var scene = level_select_scene.instantiate()
	change_to_menu(scene)
	scene.level_selected.connect(change_to_level)
	scene.add_all_levels(levels)
