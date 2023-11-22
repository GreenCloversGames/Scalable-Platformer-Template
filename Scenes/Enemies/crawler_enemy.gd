extends Enemy


# Get the gravity from the project settings to be synced with RigidBody nodes.

var facing_right = true

func handle_physics(delta):

	handle_flip()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = 1 if facing_right else -1
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func handle_flip():
	if $WallCast.is_colliding():
		flip()
	if not $Marker2D/FloorCast.is_colliding() and is_on_floor():
		flip()
		
func flip():
	facing_right = !facing_right
	$Sprite2D.flip_h = !$Sprite2D.flip_h
	$Marker2D.scale.x *= -1
