extends CharacterBody2D

var onGround = false
@export var destinationY: float #-20 a 160
@export var xSpeed: float #-240 a 290

const JUMP_VELOCITY = -400.0
const SPEED = 300

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	velocity.y = JUMP_VELOCITY

func _physics_process(delta):
	if(onGround):
		return
	
	velocity.y += gravity * delta
	velocity.x = xSpeed
	
	move_and_slide()
	
	if(position.y >= destinationY):
		onGround = true

func _on_body_entered(body):
	if(body is Player && onGround):
		body.heal(4)
		queue_free()
