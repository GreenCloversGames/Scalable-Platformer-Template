extends Node2D
class_name BaseLevel

@export_file var next_level = "res://Scenes/Virtual/BaseLevel.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

func on_player_touched(node):
	if node.is_in_group("exit"):
		get_tree().change_scene_to_file(next_level)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tile_map_changed():
	pass # Replace with function body.


func _on_tile_map_child_entered_tree(node):
	if node.is_in_group("interactable"):
		node.player_touched.connect(on_player_touched.bind(node))
	pass # Replace with function body.
