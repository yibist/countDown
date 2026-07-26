extends Control

@export var background_music: PackedScene
var first: bool = true

func _ready() -> void:
	var _background_music = background_music.instantiate()
	if first:
		get_tree().root.add_child.call_deferred(_background_music)
		first = false
