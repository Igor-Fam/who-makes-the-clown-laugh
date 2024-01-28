extends CharacterBody2D
class_name Player

@export var immune = false
@export var stunned = false

var hp = 100
var knockbackDirection : Vector2

@onready var animPlayer = $AnimationPlayer
@onready var stateMachine = $StateMachine

signal Killed

func _ready():
	pass

func _physics_process(delta):
	move_and_slide()

func _process(delta):
	if(Input.is_action_just_pressed("ui_accept")):
		Killed.emit()

func take_control():
	stateMachine.currentState.Transitioned.emit(stateMachine.currentState, "control")

func get_hit():
	hp -=1
	if(hp <= 0):
		print("aaaaaaaaa")
	else:
		stateMachine.currentState.Transitioned.emit(stateMachine.currentState, "knockback")

func teste():
	print("teste")
