extends State

@export var character : CharacterBody2D

func enter():
	character.set_physics_process(false)
	character.set_process(false)

func exit():
	character.set_physics_process(true)
	character.set_process(true)

func take_control():
	if(character is Player):
		Transitioned.emit(self, "control")
