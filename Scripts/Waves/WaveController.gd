extends Node
class_name WaveController

enum{
	R,
	L
}

var waves = ["wave1", "wave2", "wave3"]
var currentWave = 0
var enemyCount: int
var enemyPath = preload("res://Nodes/enemy.tscn")
var active = false

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var world = get_tree().get_first_node_in_group("World")
@onready var animPlayer = $AnimationPlayer

func _ready():
	
	next_wave()

func spawn_enemy(side, type):
	var enemy = enemyPath.instantiate()
	enemy.global_position = Vector2(260 if side == R else -260, -70)
	enemy.type = type
	world.add_child(enemy)

func next_wave():
	if(len(waves) == 0):
		return
	waves[0].start()

func on_wave_beaten():
	remove_child(waves[0])
	waves.pop_front()
	next_wave()
