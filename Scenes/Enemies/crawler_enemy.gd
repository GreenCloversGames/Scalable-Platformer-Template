extends Enemy


# Get the gravity from the project settings to be synced with RigidBody nodes.

var facing_right = true

func handle_physics(_delta):
	handle_flip()
	var direction = 1 if facing_right else -1
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = 0
	

func handle_flip():
	var flipped = false
	if $WallCast.is_colliding():
		flipped = true
	if not $Marker2D/FloorCast.is_colliding() and is_on_floor():
		flipped = true
	
	if flipped:
		flip()

func flip():
	facing_right = !facing_right
	if facing_right:
		$AnimationPlayer.play("FlipRight")
	else :
		$AnimationPlayer.play("FlipLeft")
	$AnimationPlayer.advance(0)
