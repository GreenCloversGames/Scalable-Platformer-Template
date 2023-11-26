extends Node2D
class_name BaseLevel

@export_file var next_level = "res://Scenes/Virtual/BaseLevel.tscn"

var current_checkpoint:Checkpoint

var player 
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

func on_player_touched(node:Interactable):
	if node is Exit:
		exit_level()
	elif node is Checkpoint:
		activate_checkpoint(node)
	pass

#Methods called by interactables/enemies

func exit_level():
	get_tree().change_scene_to_file(next_level)

func activate_checkpoint(node):
	if current_checkpoint:
		current_checkpoint.active = false
	current_checkpoint = node
	current_checkpoint.active = true
	

func respawn():
	if current_checkpoint:
		player.global_position = current_checkpoint.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tile_map_changed():
	pass # Replace with function body.


func _on_tile_map_child_entered_tree(node):
	if node.is_in_group("interactable"):
		node.player_touched.connect(on_player_touched.bind(node))
	elif node.is_in_group("player"):
		player = node
		player.player_lost_all_health.connect(respawn)
	if node.is_in_group("actor"):
		node as Actor
		node.hit_body.connect(_on_hit_body)
	pass # Replace with function body.

func _on_hit_body(body:Actor):
	body.take_hit()
