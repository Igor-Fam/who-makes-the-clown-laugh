extends State
class_name PlayerControl

@export var player : CharacterBody2D

const SPEED = 9000.0

func state_physics_update(delta):
	if(player.stunned):
		return
	
	if Input.is_action_just_pressed("ui_attack"):
		Transitioned.emit(self, "attack")
		return
	
	if Input.is_action_just_pressed("ui_roll"):
		Transitioned.emit(self, "roll")
		return
	
	var directionX = Input.get_axis("ui_left", "ui_right")
	if directionX:
		player.velocity.x = directionX * SPEED * delta
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED * delta)
		
	var directionY = Input.get_axis("ui_up", "ui_down")
	if directionY:
		player.velocity.y = directionY * SPEED * delta
	else:
		player.velocity.y = move_toward(player.velocity.y, 0, SPEED)

func exit():
	player.stateMachine.previousStateName = self.name



