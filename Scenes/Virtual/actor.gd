extends CharacterBody2D
class_name Actor

const DEFAULT_SPEED = 300.0
const DEFAULT_JUMP_HEIGHT = 2.5
const  TILESIZE = Vector2(70, 70)

@export var speed = DEFAULT_SPEED
@export_range(0, 300, 1, "suffix:px", "or_greater", "or_less", "hide_slider") var jump_height : int = 2.5:
	set(value):
		jump_height = value
		jump_vel = calculate_jump_velocity(jump_height)

@onready var jump_vel = calculate_jump_velocity(jump_height)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#Variables used to get data from last frame
var last_floor = false 
var last_velocity : Vector2

#Signals
signal hit_body(body) 

func calculate_jump_velocity(distance):
	return -sqrt(2 * gravity * distance)

func _ready():
	pass

func _process(delta):
	handle_animation(delta)

func _physics_process(delta):
	# The physics is split into multiple segments, to make sure each
	# inherited scene shares properties without having to write them again and again

	last_velocity = velocity
	last_floor = is_on_floor()
	
	handle_gravity(delta)
	handle_physics(delta)
	move_and_slide()
	#Handle all the collisions that have happened
	handle_cols()

	
func handle_physics(_delta):
	pass

func handle_animation(_delta):
	pass

func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_cols():
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * last_velocity.abs()*.1)


func _on_hitbox_body_entered(body):
	if body != self:
		hit_body.emit(body)
	pass # Replace with function body.

#These functions are used when one actor "hits" another actor

func take_hit(_hitter):
	queue_free()
	pass

func react_to_hitting(_hitbody):
	pass
