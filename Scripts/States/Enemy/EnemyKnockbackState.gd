extends State
class_name EnemyKnockback

@export var enemy : CharacterBody2D

var player : CharacterBody2D
var direction : Vector2
var speed : float

const KNOCKBACK_MOVE_SPEED = 15000.0

func enter():
	player = get_tree().get_first_node_in_group("Player")
	direction = (enemy.position - player.position).normalized()
	enemy.animPlayer.play("knockback")
		
func state_physics_update(delta):
	enemy.velocity = direction * KNOCKBACK_MOVE_SPEED * delta

func end_knockback():
	Transitioned.emit(self, enemy.stateMachine.previousStateName)






