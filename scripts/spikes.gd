extends Area2D

@export var playerBodyName: String = "graple"

func _on_body_entered(body:Node2D):
	if (body.name == playerBodyName):
		GlobalEventBus.playerDeath.emit()
