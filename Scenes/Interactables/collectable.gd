extends Interactable
class_name Collectable

@onready var anim_player : AnimationPlayer = $AnimationPlayer

var collected := false:
	set(value):
		collected = value
		if not collected and anim_player:
			show()
			anim_player.play("RESET")
			process_mode = Node.PROCESS_MODE_INHERIT
		elif collected:
			hide()
			process_mode = Node.PROCESS_MODE_DISABLED

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func collect():
	anim_player.play("Collected")
	await anim_player.animation_finished
	collected = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
