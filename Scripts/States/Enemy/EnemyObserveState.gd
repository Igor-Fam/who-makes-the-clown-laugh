extends State
class_name EnemyObserve

@export var enemy: CharacterBody2D

const WALK_SPD = 3000
const RUN_SPD = 5600

var player : CharacterBody2D
var rng = RandomNumberGenerator.new()
var speed : float
var moveDirection : Vector2
var observeDistance: float
var actDistance: float
var observeTime : float
var walkTime : float = 0
var observedPlayerKills : int

func enter():
	observeTime = rng.randf_range(8, 10)
	player = get_tree().get_first_node_in_group("Player")
	player.Killed.connect(onPlayerKill)
	observeDistance = randf_range(40000, 45000)
	actDistance = observeDistance - 15000

func state_update(delta):
	var playerDistance = enemy.global_position.distance_squared_to(player.position)
	var playerDirection = player.global_position - enemy.global_position
	
	if(playerDistance < actDistance || observeTime < 0):
		Transitioned.emit(self, "run" if randf_range(0, 10) < observedPlayerKills else "chase")
		return
		
	if(playerDistance < observeDistance):
		moveDirection = -playerDirection
		speed = RUN_SPD
		
	elif speed != 0:
		moveDirection = playerDirection.rotated(deg_to_rad(rng.randf_range(85, 95)))
		if(speed == RUN_SPD):
			speed = WALK_SPD if rng.randi_range(0, 1) == 1 else -WALK_SPD
		
	if(walkTime <= 0 && playerDistance >= observeDistance):
		walkTime = rng.randf_range(1.5, 2.5)
		
		if(speed != 0):
			speed = 0
		else:
			speed = WALK_SPD if rng.randi_range(0, 1) == 1 else -WALK_SPD
			
	walkTime -= delta
	observeTime -= delta

func state_physics_update(delta):
	enemy.velocity = moveDirection.normalized() * speed * delta

func exit():
	enemy.stateMachine.previousStateName = self.name

func onPlayerKill():
	observedPlayerKills += 1
