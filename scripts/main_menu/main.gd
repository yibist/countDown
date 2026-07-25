extends Control

@export var start_scene: StringName
@export var background_music: PackedScene

func _ready() -> void:
	var _background_music = background_music.instantiate()
	get_tree().root.add_child.call_deferred(_background_music)
	

func _on_start_pressed() -> void:
	SceneLoader.load_scene(start_scene)
