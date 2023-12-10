extends Node2D
class_name BaseLevel

@export_file var next_level = "res://Scenes/Virtual/BaseLevel.tscn"

var current_checkpoint:Checkpoint

var levelscore = 0

var player : Player

@onready var boundry_rect : Rect2i
# Called when the node enters the scene tree for the first time.
func _ready():
	var cell_size :Vector2i = $TileMap.tile_set.tile_size
	boundry_rect = Rect2i($TileMap.get_used_rect()).abs()
#	boundry_rect = boundry_rect.grow_side(SIDE_TOP, 500)
	boundry_rect.size *= cell_size
	boundry_rect.position *= cell_size
	after_ready.call_deferred()

func after_ready():
	
	player.set_up_camera_limit(boundry_rect)


func on_player_touched(node:Interactable):
	if node is Exit:
		exit_level()
	elif node is Checkpoint:
		activate_checkpoint(node)
	elif node is Collectable:
		node.collect()
		levelscore += 100
	elif node is DeathZone:
		kill_player()

#Methods called by interactables/enemies

func exit_level():
	LevelHandler.exit_level()

func activate_checkpoint(node):
	if current_checkpoint:
		current_checkpoint.active = false
	current_checkpoint = node
	current_checkpoint.active = true

func kill_player():
	get_tree().change_scene_to_file("res://Scenes/Levels/test_level.tscn")

func respawn():
	if current_checkpoint:
		player.global_position = current_checkpoint.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_tile_map_child_entered_tree(node):
	if node.is_in_group("interactable"):
		node.player_touched.connect(on_player_touched.bind(node))
	elif node.is_in_group("player"):
		player = node as Player
		player.player_lost_all_health.connect(respawn)
	if node.is_in_group("actor"):
		node as Actor
		node.hit_body.connect(_on_hit_body.bind(node))

func _on_hit_body(hitbody:Actor, hitter:Actor):
	hitbody.take_hit(hitter)
	hitter.react_to_hitting(hitbody)
