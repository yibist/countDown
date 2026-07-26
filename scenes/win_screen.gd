extends ColorRect

@export var timer: HBoxContainer
@export var timerLabel: Label
func _ready():
	GlobalEventBus.playerWin.connect(_on_player_win)

func _on_player_win():
	timerLabel.text = "Time Passed: " + timer.getTime()
	get_tree().paused = true
	visible = true
