extends Node

signal progress_advanced(progress)
signal loading_finished

var loading_scene: PackedScene = preload("uid://doj0u6jy2wmhl")
var target_scene: PackedScene
var scene_path: String
var progress: Array # 1D array with one float entry showing laod progress in % lol

func _ready() -> void:
	set_process(false)
	
func load_scene(_scene_path: String) -> void:
	scene_path = _scene_path

	var new_loading_scene = loading_scene.instantiate()
	add_child(new_loading_scene)

	progress_advanced.connect(new_loading_scene._on_progress_advanced)
	loading_finished.connect(new_loading_scene._on_loading_finished)

	await new_loading_scene.loading_screen_ready # wait until loading screen has covered screen
	
	start_load()
	
func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(scene_path, "", true)
	
	if state == OK:
		set_process(true)
		
func _process(_delta: float) -> void:
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	progress_advanced.emit(progress[0])
	
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			printerr("invalid target scene!")
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			target_scene = ResourceLoader.load_threaded_get(scene_path)
			get_tree().change_scene_to_packed(target_scene)
			loading_finished.emit()
