extends Button

@export var start_scene: StringName

func _on_pressed() -> void:
	SceneLoader.load_scene(start_scene)
