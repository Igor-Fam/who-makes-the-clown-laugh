extends TextureProgressBar

@export var clown: Clown

func _ready():
	update()
	clown.FunChanged.connect(update)

func update():
	value = clown.fun * 100 / clown.MAX_FUN
