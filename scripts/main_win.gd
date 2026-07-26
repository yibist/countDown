extends Button

@export var main_menu_scene: StringName

func _on_pressed() -> void:
	print("test")
	get_tree().paused = false
	get_tree().root.get_node("BackgroundMusic").queue_free()
	SceneLoader.load_scene(main_menu_scene)
