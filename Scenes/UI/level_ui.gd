extends CanvasLayer

@onready var healthContainer = $Control/HBoxContainer/HealthContainer
@onready var scoreContainer = $Control/HBoxContainer/ScoreContainer
@onready var timeContainer = $Control/HBoxContainer/TimeContainer
# Called when the node enters the scene tree for the first time.

@onready var hearts = healthContainer.get_node("HBoxContainer").get_children()

@onready var current_heart_index = len(hearts)-1
@onready var full_heart_tex = preload("res://Assets/UI/hud_heartFull.png")
@onready var empty_heart_tex = preload("res://Assets/UI/hud_heartEmpty.png")

func _ready():
	pass # Replace with function body.

func gain_health():
	current_heart_index = min(len(hearts)-1, current_heart_index+1)
	hearts[current_heart_index].texture = full_heart_tex

func lose_health():
	hearts[current_heart_index].texture = empty_heart_tex
	current_heart_index = max(0, current_heart_index-1)

func update_score(new_score):
	scoreContainer.get_node("Label2").text = str(new_score)

func update_time(new_time):
	timeContainer.get_node("Label2").text = String.num(new_time, 2).pad_decimals(2)
