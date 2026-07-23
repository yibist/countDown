extends Control

@export var level: StringName

func _on_button_pressed() -> void:
	SceneLoader.load_scene(level)
