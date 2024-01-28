extends StaticBody2D
class_name Clown

signal FunChanged

@export var player: Player

const MAX_FUN = 100
const FUN_DECREASE_TIME = 1

var inWave = false
var fun = 45
var funDecreaseTimer = FUN_DECREASE_TIME

@onready var bandagePath = preload("res://Nodes/bandage.tscn")
@onready var world = get_tree().get_first_node_in_group("World")

# Called when the node enters the scene tree for the first time.
func _ready():
	player.Killed.connect(increase_fun)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(!inWave):
		return
	
	if(funDecreaseTimer <= 0):
		funDecreaseTimer = FUN_DECREASE_TIME
		decrease_fun()
	else:
		funDecreaseTimer -= delta

func increase_fun():
	var increase = 7
	
	if(player.hp < 7):
		increase = 9
	
	if(player.hp < 4):
		increase = 11
	
	if(player.hp < 4):
		increase = 15
	
	fun = min(fun + increase, MAX_FUN)
	
	FunChanged.emit()

func decrease_fun():
	var decrease = 2
	
	if(player.timeWithoutDamage > 10):
		decrease = 3
	
	if(player.timeWithoutDamage > 17):
		decrease = 4
	
	if(player.timeWithoutDamage > 25):
		decrease = 6
	
	fun = max(0, fun - decrease)
	
	FunChanged.emit()

func throw_bandage():
	var bandage = bandagePath.instantiate()
	bandage.xSpeed = randf_range(-240, 290)
	bandage.destinationY = randf_range(-20, 160)
	bandage.position = Vector2(-50, -170)
	world.add_child(bandage)
