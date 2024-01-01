extends Node2D
class_name BaseLevel

@onready var boundry_rect : Rect2i
@onready var player_scene = preload("res://Scenes/Player/player.tscn")

var levelscore = 0
var time_taken = 0
var starting_pos : Vector2

var level_resource : LevelResource
var player : Player
@onready var ui := $LevelUI

var current_checkpoint:Checkpoint


signal level_ended

# Called when the node enters the scene tree for the first time.
func _ready():
	var cell_size :Vector2i = $TileMap.tile_set.tile_size
	boundry_rect = Rect2i($TileMap.get_used_rect()).abs()
#	boundry_rect = boundry_rect.grow_side(SIDE_TOP, 500)
	boundry_rect.size *= cell_size
	boundry_rect.position *= cell_size
	after_ready.call_deferred()

func _process(delta):
	time_taken += delta
	ui.update_time(time_taken)
	

func after_ready():
	#As the player is added to the tilemap, it needs to wait a frame for 
	#everything to get ready!
	player.set_up_camera_limit(boundry_rect)
	starting_pos = player.position

func on_player_touched(node:Interactable):
	if node is Exit:
		exit_level()
	elif node is Checkpoint:
		activate_checkpoint(node)
	elif node is Collectable:
		node.collect()
		update_score(100)
	elif node is DeathZone:
		kill_player()

#Methods called by interactables/enemies

func update_score(value):
	levelscore += value
	ui.update_score(levelscore)

func reset_score():
	levelscore = 0
	ui.update_score(levelscore)

func exit_level():
	level_ended.emit()

func activate_checkpoint(node):
	if current_checkpoint:
		current_checkpoint.active = false
	current_checkpoint = node
	current_checkpoint.active = true

func kill_player():
	respawn.call_deferred()

func respawn():
	player.queue_free()
	player = player_scene.instantiate()
	$TileMap.add_child(player)
	player.set_up_camera_limit(boundry_rect)
	if current_checkpoint:
		player.global_position = current_checkpoint.global_position
	else:
		player.global_position = starting_pos
	
	for collectable in get_tree().get_nodes_in_group("collectable"):
		collectable.collected = false
	reset_score()
	

func _on_tile_map_child_entered_tree(node):
	# Handle the noeds that are instanced by the tile map.
	# Potential change - Have them added to the test level instead?
	
	if node.is_in_group("interactable"):
		node.player_touched.connect(on_player_touched.bind(node))
	if node.is_in_group("player"):
		player = node as Player
		player.player_lost_health.connect(_on_player_lost_health)
		player.player_lost_all_health.connect(respawn)
	if node.is_in_group("actor"):
		node = node as Actor
		node.hit_body.connect(_on_hit_body.bind(node))

func _on_hit_body(hitbody:Actor, hitter:Actor):
	hitbody.take_hit(hitter) 
	hitter.react_to_hitting(hitbody)

func _on_player_lost_health(_new_health):
	ui.lose_health()
