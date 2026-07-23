extends CharacterBody2D

@export var player: CharacterBody2D
@export var speed: float = 2000.0  
var move_direction: Vector2
var hit: bool = false
var rope: PinJoint2D;
var ropeLength: float;

func _ready() -> void:
	top_level = true;
	hide()
	
func spawn() -> void:
	var mouse_pos = get_global_mouse_position()
	var parent_pos = get_parent().global_position
	
	move_direction = (mouse_pos - parent_pos).normalized()
	
	global_position = parent_pos + (move_direction * 10)
	
	look_at(global_position + move_direction)
	rotation += deg_to_rad(90)
	hit = false
	show()
	
func despawn() -> void:
	hide()
	
func _process(delta: float) -> void:
	if not hit:
		var collision = move_and_collide(move_direction * speed * delta)
		if collision:
			hit = true
			ropeLength = global_position.distance_to(player.global_position)
			global_position += move_direction * 10
