extends State
class_name PlayerKnockback

@export var player : CharacterBody2D

var direction : Vector2
var speed : float
var knockbackTimer

const KNOCKBACK_MOVE_SPEED = 20000.0
const KNOCKBACK_TIME = 0.1

func enter():
	player = get_tree().get_first_node_in_group("Player")
	direction = player.knockbackDirection
	knockbackTimer = KNOCKBACK_TIME
	player.immune = true
	player.stunned = true

func state_physics_update(delta):
	if(knockbackTimer > 0):
		knockbackTimer -= delta
	else:
		end_knockback()
		return
	player.velocity = direction * KNOCKBACK_MOVE_SPEED * delta

func end_knockback():
	print("end")
	Transitioned.emit(self, player.stateMachine.previousStateName)
	player.stunned = false
	await get_tree().create_timer(0.25).timeout
	player.immune = false






