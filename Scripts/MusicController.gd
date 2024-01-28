extends Node

@onready var tracks = get_children()
@onready var tracksPlaying = tracks.map(func(track): return false)

func play_all():
	for track in tracks:
		track.playing = true
		track.volume_db = 0

func toggle(i: int):
	tracksPlaying[i] = !tracksPlaying[i]

func _ready():
	play_all()

func _process(delta):
	
	if(Input.is_action_just_pressed('1')):
		toggle(0)
	if(Input.is_action_just_pressed('2')):
		toggle(1)
	if(Input.is_action_just_pressed('3')):
		toggle(2)
	if(Input.is_action_just_pressed('4')):
		toggle(3)
	
	for i in range(len(tracks)):
		if(!tracksPlaying[i]):
			if(tracks[i].volume_db > -70):
				tracks[i].volume_db -= 1
		else:
			if(tracks[i].volume_db < 0):
				tracks[i].volume_db += 1
