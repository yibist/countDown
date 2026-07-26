extends ColorRect

@export var timer: HBoxContainer
@export var timerLabel: Label
func _ready():
	GlobalEventBus.playerDeath.connect(_on_player_death)

func _on_player_death():
	timerLabel.text = timer.getTime()
	get_tree().paused = true
	visible = true
