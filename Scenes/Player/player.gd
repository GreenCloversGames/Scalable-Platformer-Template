extends Actor

@export var coyote_time_frames = 3;

#Taken from Kids Can Code - https://kidscancode.org/godot_recipes/4.x/2d/platform_character/index.html

@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25


var  can_jump = true

signal player_lost_all_health

func _ready():
	super()
	%CoyoteTimer.wait_time = (coyote_time_frames/1)
	SceneTrainsition.target = self


func handle_animation(delta):
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
	
func handle_physics(delta):
	
	if not is_on_floor() and can_jump and %CoyoteTimer.is_stopped():
		%CoyoteTimer.start()
		
	elif is_on_floor():
		can_jump = true
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and can_jump:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

func take_hit():
	player_lost_all_health.emit()

func _on_coyote_timer_timeout():
	if not is_on_floor():
		can_jump = false
	pass # Replace with function body.
