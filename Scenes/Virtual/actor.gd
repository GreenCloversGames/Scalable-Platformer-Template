extends CharacterBody2D
class_name Actor

const DEFAULT_SPEED = 300.0
const JUMP_VELOCITY = -550.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal hit_body(body) 

@export var speed = DEFAULT_SPEED

func _ready():
	pass

func _process(delta):
	handle_animation(delta)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	handle_physics(delta)
	move_and_slide()

func handle_physics(delta):
	pass

func handle_animation(delta):
	pass


func _on_hitbox_body_entered(body):
	if body != self:
		print(body, "has been hit!")
		hit_body.emit(body)
	pass # Replace with function body.

func take_hit():
	queue_free()
	pass
