extends Control

@export var background_music: PackedScene

func _ready() -> void:
	var _background_music = background_music.instantiate()
	get_tree().root.add_child.call_deferred(_background_music)
	
