extends Interactable
class_name Checkpoint

var active : bool = false : 
	set (value):
		if value:
			$Sprite2D.play("active")
		else:
			$Sprite2D.play("inactive")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
