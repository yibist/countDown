extends HBoxContainer

@export var startTime: float = 10.0
@export var msLabel: Label
@export var sLabel: Label

var timeRemaining: float = 0.0

func _ready():
	reset_timer()

func _process(delta: float) -> void:
	timeRemaining -= delta
	
	if timeRemaining < 0.0:
		timeRemaining = 0.0
	
	var seconds: int = floori(timeRemaining)
	var fractional: int = floori((timeRemaining - seconds) * 10000)
	
	if sLabel:
		sLabel.text = str(seconds)
	
	if msLabel:
		msLabel.text = str(fractional).pad_zeros(4)

func getTime() -> String:
	var seconds: int = floori(timeRemaining)
	var fractional: int = floori((timeRemaining - seconds) * 10000)
	return str(seconds) + ":" + str(fractional).pad_zeros(4)

func reset_timer():
	timeRemaining = startTime

func is_finished() -> bool:
	return timeRemaining <= 0.0
