extends State
class_name EnemyChase

@export var enemy: CharacterBody2D

const RUN_SPD = 8000
const ATTACK_RANGE = 2000
const ATTACK_COOLDOWN = 2

var player : CharacterBody2D
var rng = RandomNumberGenerator.new()
var moveDirection : Vector2
var attackCooldown : float = 0

func enter():
	player = get_tree().get_first_node_in_group("Player")

func state_update(delta):
	var playerDistance = enemy.global_position.distance_squared_to(player.position)
	
	moveDirection = player.global_position - enemy.global_position
	
	if(playerDistance < ATTACK_RANGE):
		moveDirection = Vector2(0, 0)
		if(attackCooldown <= 0):
			Transitioned.emit(self, "attack")
			attackCooldown = ATTACK_COOLDOWN
	

func state_physics_update(delta):
	if(attackCooldown > 0):
		attackCooldown -= delta
	enemy.velocity = moveDirection.normalized() * RUN_SPD * delta

func exit():
	enemy.stateMachine.previousStateName = self.name
