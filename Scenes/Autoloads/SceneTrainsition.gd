extends CanvasLayer

var target : Node2D 

signal transition_ended

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !target:
		return
	var value_on_screen := target.get_global_transform_with_canvas().origin / get_viewport().get_visible_rect().size 
	var shader_mat = $SceneTransition/ColorRect.material as Material
	shader_mat.set("shader_parameter/screen_location", value_on_screen)
	pass

func transition_in():
	$SceneTransition/AnimationPlayer.play("CircleIn")

func transition_out():
	$SceneTransition/AnimationPlayer.play("CircleOut")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "CircleIn":
		transition_ended.emit()
	pass # Replace with function body.



