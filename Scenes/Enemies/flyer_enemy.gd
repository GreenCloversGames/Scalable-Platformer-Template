extends Enemy

@onready var player_in_sight = false
var player : Player

func handle_physics(_delta):
	if player_in_sight:
		velocity = global_position.direction_to(player.global_position)*speed
		
func handle_gravity(_delta):
	pass


func _on_target_range_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player_in_sight = true
	pass # Replace with function body.


func _on_target_range_body_exited(body):
	if body.is_in_group("player"):
		player_in_sight = false
	pass # Replace with function body.
