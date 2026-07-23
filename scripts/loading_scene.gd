extends CanvasLayer

signal loading_screen_ready

@export var animation_player: AnimationPlayer

func _ready() -> void:
	await animation_player.animation_finished
	loading_screen_ready.emit()

func _on_progress_advanced(progress: float) -> void: # can be used to display percentage bars
	pass

func _on_loading_finished() -> void:
	animation_player.play_backwards("fade")
	await animation_player.animation_finished
	queue_free()
