extends Wave
class_name Wave1

func start():
	await wait(0.5)
	active = true
	enemyCount = 4
	spawn_enemy(R, Enemy.OBSERVER)
	await wait(0.5)
	spawn_enemy(L, Enemy.OBSERVER)
	await wait(2.5)
	spawn_enemy(L, Enemy.OBSERVER)
	await wait(6.5)
	spawn_enemy(R, Enemy.OBSERVER)
