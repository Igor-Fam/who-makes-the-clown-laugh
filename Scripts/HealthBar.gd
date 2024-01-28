extends TextureProgressBar

@export var player: Player

func _ready():
	update()
	player.HealthChanged.connect(update)

func update():
	value = player.hp * 100 / player.MAX_HP
