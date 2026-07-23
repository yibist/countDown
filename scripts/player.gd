extends CharacterBody2D

@export var grapleHead: CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 20.0  
const FRICTION = 8.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
		
	var direction := Input.get_axis("moveLeft", "moveRight")
	if direction and is_on_floor():
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION)
		
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, FRICTION)
		
	

	move_and_slide()
	if grapleHead.hit:
		var hook_point = grapleHead.global_position
		var max_length = grapleHead.ropeLength
		
		var to_player = global_position - hook_point
		var distance = to_player.length()
		
		if distance > max_length:
			var direction_to_hook = to_player.normalized()
			
			var radial_velocity = direction_to_hook * velocity.dot(direction_to_hook)
			var tangential_velocity = velocity - radial_velocity
			
			velocity = tangential_velocity
			
			global_position = hook_point + direction_to_hook * max_length
