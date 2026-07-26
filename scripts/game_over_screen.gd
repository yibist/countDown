extends ColorRect


func _ready():
	GlobalEventBus.playerDeath.connect(_on_player_death)

func _on_player_death():
	print("Player died!")
	get_tree().paused = true
	visible = true
