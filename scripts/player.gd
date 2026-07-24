extends CharacterBody2D

@export var grapleHead: CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 20.0  
const FRICTION = 8.0
const SWINGFORCE = 300
var jumps = 2;


func _physics_process(delta: float) -> void:
	
	var hookPoint = grapleHead.global_position
	var maxLength = grapleHead.ropeLength
	var toPlayer = global_position - hookPoint
	var distance = toPlayer.length()
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		jumps = 2

	if Input.is_action_just_pressed("jump") && jumps > 0:
		velocity.y = JUMP_VELOCITY
		jumps -= 1
		
	var isSwinging = grapleHead.hit and distance >= maxLength
	var direction := Input.get_axis("moveLeft", "moveRight")

	if isSwinging:
		var directionToHook = toPlayer.normalized()
		var radialVelocity = directionToHook * velocity.dot(directionToHook)
		var tangentialVelocity = velocity - radialVelocity
		
		if direction:
			var perpendicular = Vector2(-directionToHook.y, directionToHook.x)
			tangentialVelocity -= perpendicular * direction * SWINGFORCE * delta
		
		velocity = tangentialVelocity
		global_position = hookPoint + directionToHook * maxLength
	else:
		if direction:
			velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION)
		elif is_on_floor():
			velocity.x = move_toward(velocity.x, 0, FRICTION)
	
	move_and_slide()
