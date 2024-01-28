extends Node
class_name WaveController

@export var enemyCount: int

var waves = ["wave1", "wave2", "wave3"]
var currentWave = -1
var enemyPath = preload("res://Nodes/enemy.tscn")
var active = false

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var clown = get_tree().get_first_node_in_group("Clown")
@onready var world = get_tree().get_first_node_in_group("World")
@onready var pauseController = get_tree().get_first_node_in_group("Pause")
@onready var animPlayer = $AnimationPlayer

func _ready():
	player.Killed.connect(on_enemy_kill)
	next_wave()

func spawn_enemy(side: String, type: String):
	var enemy = enemyPath.instantiate()
	enemy.global_position = Vector2(260 if side == "R" else -260, -70)
	match type:
		"AGGRESSIVE": 
			enemy.type = Enemy.AGGRESSIVE
		"OBSERVER": 
			enemy.type = Enemy.OBSERVER
		"PACIFIST": 
			enemy.type = Enemy.PACIFIST
	world.add_child(enemy)

func next_wave():
	currentWave += 1
	animPlayer.play(waves[currentWave])
	print(waves[currentWave])

func on_enemy_kill():
	enemyCount -= 1
	if(enemyCount <= 0):
		toggle_in_wave()
		next_wave()

func toggle_in_wave():
	clown.inWave = !clown.inWave

func throw_bandage():
	clown.throw_bandage()
