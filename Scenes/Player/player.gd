extends Actor
class_name Player

@export var coyote_time_frames = 6;
@export var jump_time_frames = 6;


#Taken from Kids Can Code - https://kidscancode.org/godot_recipes/4.x/2d/platform_character/index.html

@onready var camera :Camera2D = $Camera2D 

@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25


var health = 3

var jumping = true

#Coyote code based on KIDS CAN CODE
#https://kidscancode.org/godot_recipes/4.x/2d/coyote_time/index.html

var coyote_frames = 30 # How many in-air frames to allow jumping
var coyote = false  # Track whether we're in coyote time or not



signal player_lost_health(new_health)
signal player_lost_all_health

func _ready():
	super()
	%CoyoteTimer.wait_time = coyote_frames / 60.
	%JumpBufferTimer.wait_time = jump_time_frames / 60.
	SceneTrainsition.target = self


func handle_animation(_delta):
	if is_on_floor():
		if velocity.x > 5:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = false
		elif velocity.x < -5:
			$AnimatedSprite2D.play("walk")
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.play("default")
	else:
		if velocity.y < 0:
			$AnimatedSprite2D.play("jump")
		else:
			$AnimatedSprite2D.play("fall")

func handle_gravity(delta):
	if velocity.y > 0:
		delta *= 1.5
	super(delta)

func handle_physics(_delta):
	if is_on_floor():
		jumping = false
	# Handle Jump.
	
	handle_jump()

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

func handle_jump():
	if Input.is_action_just_pressed("jump"):
		%JumpBufferTimer.start()
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.25
	if (not %JumpBufferTimer.is_stopped()) and (is_on_floor() or coyote):
		velocity.y = jump_vel
		%JumpBufferTimer.stop()
		jumping = true
		if coyote:
			coyote = false

func handle_cols():
	super()
	
	if !is_on_floor() and last_floor and not jumping:
		coyote = true
		%CoyoteTimer.start()
	

func take_hit(hitter):
	velocity.x = global_position.direction_to(hitter.global_position).x * jump_vel * 3
	if is_on_floor():
		velocity.y = jump_vel*.5
	$AnimatedSprite2D.play("hurt")
	health -= 1
	player_lost_health.emit(health)
	if health <= 0:
		player_lost_all_health.emit()

func set_up_camera_limit(rect:Rect2i):
	print(rect)
	rect = rect.abs()
	camera.limit_left = rect.position.x 
	camera.limit_top = rect.position.y
	camera.limit_right = rect.end.x
	camera.limit_bottom = rect.end.y

func _on_coyote_timer_timeout():
	coyote = false
	pass # Replace with function body.

func react_to_hitting(_hitbody):
	# Have the player jump
	velocity.y = jump_vel
	jumping = true


