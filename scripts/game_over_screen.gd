extends ColorRect

@export var timer: HBoxContainer
@export var timerLabel: Label
@export var nameLabel: Label

func _ready():
	GlobalEventBus.playerDeath.connect(_on_player_death)
	GlobalEventBus.playerWin.connect(onWin)


func _on_player_death():
	nameLabel.text = "GAME OVER"
	timerLabel.text = timer.getTime()
	get_tree().paused = true
	visible = true
	
func onWin():
	nameLabel.text = "WIN"
	timerLabel.text = timer.getTime()
	get_tree().paused = true
	visible = true
