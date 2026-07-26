extends CharacterBody2D

@export var grapleHead: CharacterBody2D
@export var landParticles: CPUParticles2D
@export var sprite: Sprite2D
@export var landingSound: AudioStreamPlayer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 20.0  
const FRICTION = 8.0
const SWINGFORCE = 300
var jumps = 2;
var dashes = 1;
const WHEELRADIUS = 30
var dashCooldown: float = 1.0
var dashTimer: float = 0.0


func _physics_process(delta: float) -> void:
	var hookPoint = grapleHead.global_position
	var maxLength = grapleHead.ropeLength
	var toPlayer = global_position - hookPoint
	var distance = toPlayer.length()
	dashTimer -= delta
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jumps = 2
		dashes = 1

	if Input.is_action_just_pressed("jump") && jumps > 0:
		velocity.y = JUMP_VELOCITY
		jumps -= 1
	
	if Input.is_action_just_pressed("dash") and dashes > 0 and dashTimer <= 0:
		var currentSpeed = velocity.length()
		var mousePos = get_global_mouse_position()
		var mouseDir = (mousePos - global_position).normalized()
		velocity = mouseDir * (max(currentSpeed,SPEED) + 100)
		dashTimer = dashCooldown
		dashes -= 1
	
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
			if is_on_floor():
				velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION)
			elif abs(velocity.x) <= SPEED:
				velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION)
			elif velocity.x > SPEED and direction < 0:
				velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION)
			elif velocity.x < -SPEED and direction > 0:
				velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION)
				
		elif is_on_floor():
			velocity.x = move_toward(velocity.x, 0, FRICTION)

	var tempVelocity = velocity
	move_and_slide()
	emit_land_particles(tempVelocity)
	update_wheel_rotation(delta)
	
	
	
func emit_land_particles(currentVelocity:Vector2):
	var collisionCount = get_slide_collision_count()
	if collisionCount == 0:
		return

	
	for i in range(collisionCount):
		var collision = get_slide_collision(i)
		if collision == null:
			continue
		var collisionNormal = collision.get_normal()
		var collisionPoint = collision.get_position()
		
		var impactSpeed = currentVelocity.dot(-collisionNormal)
		
		if impactSpeed > 400:
			spawn_particles(collisionPoint, collisionNormal, impactSpeed)

func spawn_particles(position: Vector2, normal: Vector2, impactSpeed: float = 0.0):
	landingSound.pitch_scale = randf_range(0.7, 1.3)
	landingSound.volume_db = min(-20 + impactSpeed / 100, -1)
	landingSound.play()
	
	landParticles.global_position = position
	landParticles.rotation = normal.angle() + PI/2
	
	var speedFactor = max(0, impactSpeed - 500.0) / 100.0
	landParticles.scale = Vector2.ONE * (1.0 + speedFactor * 0.5)
	landParticles.amount = int(10 + pow(speedFactor, 2) * 10)
	landParticles.restart()
	landParticles.emitting = true

func update_wheel_rotation(delta:float):

	var angularVelocity = velocity.x / WHEELRADIUS
	var speed_factor = 1.0
	angularVelocity *= speed_factor
	sprite.rotation += angularVelocity * delta
	
	
	
func despawn():
	grapleHead.despawn()
	
	
		
		
		
	
		
