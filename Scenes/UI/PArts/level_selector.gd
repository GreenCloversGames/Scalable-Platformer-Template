@tool
extends Control

@onready var button := $VBoxContainer/Button

@export var level_name := "Level X":
	set(value):
		level_name = value
		$VBoxContainer/Button.text = value

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
