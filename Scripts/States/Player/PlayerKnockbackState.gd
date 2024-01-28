extends State
class_name PlayerKnockback

@export var player : CharacterBody2D

var direction : Vector2
var speed : float

const KNOCKBACK_MOVE_SPEED = 20000.0

func enter():
	player = get_tree().get_first_node_in_group("Player")
	direction = player.knockbackDirection
	player.animPlayer.play("knockback")
	player.immune = true
	player.stunned = true

func state_physics_update(delta):
	player.velocity = direction * KNOCKBACK_MOVE_SPEED * delta

func end_knockback():
	Transitioned.emit(self, player.stateMachine.previousStateName)
	player.stunned = false
	await get_tree().create_timer(0.25).timeout
	player.immune = false






