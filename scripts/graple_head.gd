extends Sprite2D

@export var speed: float = 2000.0  
var move_direction: Vector2

func _ready() -> void:
	top_level = true;
	hide()
	
func spawn() -> void:
	var mouse_pos = get_global_mouse_position()
	var parent_pos = get_parent().global_position
	
	move_direction = (mouse_pos - parent_pos).normalized()
	
	global_position = parent_pos + (move_direction * 50)
	
	look_at(global_position + move_direction)
	rotation += deg_to_rad(90)
	show()
	
func despawn() -> void:
	hide()
	
func _process(delta: float) -> void:
	global_position += move_direction * speed * delta
