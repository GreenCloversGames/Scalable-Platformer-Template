extends Interactable
class_name Collectable


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func collect():
	$AnimationPlayer.play("Collected")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
