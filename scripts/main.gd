extends Control

@export var start_scene: StringName

func _ready() -> void:
	pass
	

func _on_start_pressed() -> void:
	SceneLoader.load_scene(start_scene)
