extends State
class_name PlayerRoll

@export var player : CharacterBody2D

var direction : Vector2
var speed : float

const ROLL_SPEED = 30000.0
const ACCEL = 0.95

var enemies

func enter():
	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_up", "ui_down")
	direction = Vector2(directionX, directionY).normalized()
	
	speed = ROLL_SPEED
	
	enemies = get_tree().get_nodes_in_group("Enemies")
	
	for enemy in enemies:
		enemy.add_collision_exception_with(player)

	player.animPlayer.play("roll")
	player.immune = true

func state_physics_update(delta):
	speed *= ACCEL
	player.velocity = direction * speed * delta * ACCEL

func exit():
	player.immune = false
	for enemy in enemies:
		enemy.remove_collision_exception_with(player)

func end_roll():
	Transitioned.emit(self, "control")






