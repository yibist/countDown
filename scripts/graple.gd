extends AnimatedSprite2D

@export var grapleHead: Sprite2D
var orbit_distance: float = 0.0
var parent_node: Node2D

func _ready() -> void:
	parent_node = get_parent()
	orbit_distance = global_position.distance_to(parent_node.global_position)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("grapleHook"):
		fireGrapleHook()
	
	var mouse_pos = get_global_mouse_position()
	var parent_pos = parent_node.global_position
	var direction = (mouse_pos - parent_pos).normalized()
	
	global_position = parent_pos + (direction * orbit_distance)
	look_at(mouse_pos)
	rotation += deg_to_rad(90)


func fireGrapleHook() -> void:
	if grapleHead:
		grapleHead.spawn()
