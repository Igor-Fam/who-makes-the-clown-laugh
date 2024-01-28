extends State
class_name EnemyAttack

@export var enemy : CharacterBody2D

var player : CharacterBody2D
var direction : Vector2
var speed : float

const ATTACK_MOVE_SPEED = 7000.0

func enter():
	player = get_tree().get_first_node_in_group("Player")
	direction = (player.position - enemy.position).normalized()
	enemy.animPlayer.play("attack")

func state_physics_update(delta):
	enemy.velocity = direction * ATTACK_MOVE_SPEED * delta

func exit():
	if(enemy.animPlayer.current_animation == "attack" && enemy.animPlayer.is_playing()):
		enemy.animPlayer.stop()

func end_attack():
	Transitioned.emit(self, enemy.stateMachine.previousStateName)






