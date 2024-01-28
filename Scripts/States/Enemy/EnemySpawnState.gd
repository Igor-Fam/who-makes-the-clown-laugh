extends State
class_name EnemySpawn

var stop = false

@export var enemy : CharacterBody2D

const SPEED = 9000


func state_physics_update(delta):
	if(stop):
		enemy.velocity = Vector2(0, 0)
		return
	enemy.velocity = Vector2(0, SPEED * delta)

func enemy_stop():
	enemy.immune = false
	stop = true

func end_spawn():
	var nextState
	match enemy.type:
		Enemy.AGGRESSIVE: 
			nextState = "chase"
		Enemy.OBSERVER:
			nextState = "observe"
		Enemy.PACIFIST:
			nextState = "run"
	
	Transitioned.emit(self, nextState)






