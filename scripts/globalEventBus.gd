extends Node

signal playerDeath

func _ready() -> void:
	GlobalEventBus.connect("playerDeath", _on_playerDeath)

func _on_playerDeath() -> void:
	print("Player died")
