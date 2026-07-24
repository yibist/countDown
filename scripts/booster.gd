extends Area2D

@export var playerBodyName:String = "Player"
@export var direction := 0
@export var boostAmount := 5000

func _ready() -> void:
	pass

func _on_body_entered(body:Node2D):
	if (body.name == playerBodyName):
		if (direction == 0):
			body.velocity.x += boostAmount
		if (direction == 1):
			body.velocity.x -= boostAmount
		if (direction == 2):
			body.velocity.y += boostAmount
		if (direction == 3):
			body.velocity.y -= boostAmount
