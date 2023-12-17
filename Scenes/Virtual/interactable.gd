extends Area2D
class_name Interactable

signal player_touched


func _on_body_entered(body):
	if body.is_in_group("player"):
		player_touched.emit()
	pass # Replace with function body.
