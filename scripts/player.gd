extends CharacterBody2D


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
	if direction && abs(velocity.x) <= SPEED:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION)
		
	elif is_on_floor() and not Input.is_action_pressed("jump"):
		velocity.x = move_toward(velocity.x, 0, FRICTION)
		
	

	move_and_slide()
