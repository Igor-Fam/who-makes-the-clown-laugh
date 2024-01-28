extends Area2D

func set_angle():
	look_at(get_global_mouse_position())

func _on_body_entered(body):
	if body is Enemy && !body.immune:
		body.get_hit()
