extends Area2D

@export var BodyName:String = "GrapleHead"

func _ready() -> void:
	add_to_group("grappleDespawnZone", true)
