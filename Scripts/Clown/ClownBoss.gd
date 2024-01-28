extends StaticBody2D

const IMMUNITY_TIME = 0.5

@export var player : CharacterBody2D
@export var world: Node2D

var immunityTimer: float



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if(immunityTimer > 0):
		immunityTimer -= delta
