extends Button

func _on_pressed() -> void:
	print("test")
	var tree := get_tree()
	tree.paused = false
	tree.reload_current_scene()
