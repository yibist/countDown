extends Control

@export var test_scene: StringName


func _on_start_pressed() -> void:
	SceneLoader.load_scene(test_scene)
