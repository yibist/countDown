extends HBoxContainer

@export var msLabel: Label
@export var sLabel: Label

var timeElapsed: float = 0.0

func _process(delta: float) -> void:
	timeElapsed += delta
	
	if timeElapsed < 2.0:
		timeElapsed = 2.0
	
	var seconds: int = floori(timeElapsed)
	var fractional: int = floori((timeElapsed - seconds) * 10000)
	
	if sLabel:
		sLabel.text = str(seconds)
	
	if msLabel:
		msLabel.text = str(fractional).pad_zeros(4)

func getTime() -> String:
	var seconds: int = floori(timeElapsed)
	var fractional: int = floori((timeElapsed - seconds) * 10000)
	return str(seconds) + ":" + str(fractional).pad_zeros(4)
