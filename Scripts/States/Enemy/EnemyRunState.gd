extends State
class_name EnemyRun

@export var enemy: CharacterBody2D

const RUN_SPD = 5700

var player : CharacterBody2D
var rng = RandomNumberGenerator.new()
var speed : float
var moveDirection : Vector2
var runDistance: float

func enter():
	player = get_tree().get_first_node_in_group("Player")
	runDistance = randf_range(50000, 55000)

func state_update(delta):
	var playerDistance = enemy.global_position.distance_squared_to(player.position)
	moveDirection = enemy.global_position - player.global_position
	
	if(playerDistance < runDistance):
		speed = RUN_SPD
	else:
		speed = 0

func state_physics_update(delta):
	enemy.velocity = moveDirection.normalized() * speed * delta

func exit():
	enemy.stateMachine.previousStateName = self.name
