extends Area2D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var enemy = get_parent()

func set_angle():
	look_at(player.position)

func _on_body_entered(body):
	if body is Player && !body.immune:
		body.knockbackDirection = (player.global_position - enemy.global_position).normalized()
		body.get_hit(1)
