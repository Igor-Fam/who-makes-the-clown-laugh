extends CharacterBody2D
class_name Player

const MAX_HP = 10
const ROLL_COOLDOWN = 1

@export var immune = false
@export var stunned = false

var hp = 10
var timeWithoutDamage = 0
var knockbackDirection : Vector2
var rollCooldown = 0

@onready var animPlayer = $AnimationPlayer
@onready var stateMachine = $StateMachine

signal Killed
signal HealthChanged

func _ready():
	pass

func _physics_process(delta):
	timeWithoutDamage += delta
	
	if(rollCooldown > 0):
		rollCooldown -= delta
		
	move_and_slide()

func _process(delta):
	if(Input.is_action_just_pressed("ui_accept")):
		print("animation: " + animPlayer.current_animation)

func take_control():
	stateMachine.currentState.Transitioned.emit(stateMachine.currentState, "control")

func get_hit(damage):
	timeWithoutDamage = 0
	hp -= damage
	if(hp <= 0):
		print("aaaaaaaaa")
	else:
		stateMachine.currentState.Transitioned.emit(stateMachine.currentState, "knockback")
	HealthChanged.emit()

func heal(health):
	hp = min(hp + health, MAX_HP)
	HealthChanged.emit()

