extends State
class_name PlayerAttack

@export var player : CharacterBody2D

var direction : Vector2
var speed : float

const ATTACK_MOVE_SPEED = 3000.0

var enemies

func enter():
	direction = (player.get_global_mouse_position() - player.position).normalized()
	player.animPlayer.play("attack")

func state_physics_update(delta):
	player.velocity = direction * ATTACK_MOVE_SPEED * delta

func exit():
	if(player.animPlayer.current_animation == "attack" && player.animPlayer.is_playing()):
		player.animPlayer.stop()

func end_attack():
	Transitioned.emit(self, "control")






