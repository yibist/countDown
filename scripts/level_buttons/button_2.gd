extends Button

@export var level: StringName

func _on_pressed() -> void:
	SceneLoader.load_scene(level)
