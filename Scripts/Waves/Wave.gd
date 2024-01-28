extends Node
class_name Wave

signal Beaten

enum{
	R,
	L
}

var enemyCount: int
var enemyPath = preload("res://Nodes/enemy.tscn")
var active = false

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var world = get_tree().get_first_node_in_group("World")

func _ready():
	player.Killed.connect(on_enemy_kill)

func spawn_enemy(side, type):
	var enemy = enemyPath.instantiate()
	enemy.global_position = Vector2(260 if side == R else -260, -70)
	enemy.type = type
	world.add_child(enemy)

func start():
	pass

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout

func on_enemy_kill():
	if(!active):
		return
	enemyCount -= 1
	if(enemyCount <= 0):
		Beaten.emit()
		queue_free()
