extends AudioStreamPlayer

var audioPlayers: Array[AudioStreamPlayer] = []


@export var drum2: AudioStreamPlayer
@export var drum3: AudioStreamPlayer
@export var bass1: AudioStreamPlayer
@export var synth1: AudioStreamPlayer

var timer: Timer
var loopCount: int = 0
var synthOn: bool = false


func _ready() -> void:
	audioPlayers = [drum2, drum3, bass1, synth1]
	timer = Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(_on_loop_completed)
	
	timer.start(stream.get_length())

func _on_loop_completed() -> void:
	turnOffAll()
	loopCount += 1
	if loopCount == 4:
		drum3.play()
		timer.start(drum3.stream.get_length())
	elif loopCount == 3:
		synthOn = true
		synth1.play()
		timer.start(synth1.stream.get_length())
	else:
		if synthOn:
			synth1.play()
		play()
		drum2.play()
		bass1.play()
		timer.start(stream.get_length())


func turnOffAll() -> void:
	for player in audioPlayers:
		player.stop()
