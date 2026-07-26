extends Node

func _on_pressed() -> void:
	var tree := get_tree()
	tree.paused = false
	tree.reload_current_scene()
