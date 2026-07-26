extends Area2D

@export var BodyName:String = "GrapleHead"

func _on_body_entered(body:CharacterBody2D):
	if (body.name == BodyName):
		body.despawn()
