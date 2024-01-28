extends CharacterBody2D
class_name Enemy

@export var hp : int

enum{
	OBSERVER,
	AGGRESSIVE,
	PACIFIST
}

var immune = true
var type = OBSERVER

@onready var animPlayer = $AnimationPlayer
@onready var stateMachine = $StateMachine
@onready var player = get_tree().get_first_node_in_group("Player")

func _ready():
	animPlayer.play("spawn")

func _physics_process(delta):
	move_and_slide()

func get_hit():
	hp -=1
	if(hp <= 0):
		die()
	else:
		stateMachine.currentState.Transitioned.emit(stateMachine.currentState, "knockback")

func die():
	player.Killed.emit()
	queue_free()


