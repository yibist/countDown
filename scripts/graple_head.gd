extends CharacterBody2D

@export var player: CharacterBody2D
@export var line: Line2D
@export var speed: float = 2000.0  
@export var ropeSegment: PackedScene
@export var ropeEnd: PackedScene
@export var landingSound: AudioStreamPlayer2D


var move_direction: Vector2
var hit: bool = false
var rope: PinJoint2D;
var ropeLength: float;
var reeling: bool = false
var spawned:bool = false
var ropeSegments = []
var ropeJoints = []
var reelAmount: float = 0
var segmentsRemoved: int = 0
var segmentSpacing: float = 20.0

func _ready() -> void:
	top_level = true;
	line.top_level = true;
	hide()
	
func spawn() -> void:
	spawned = true
	var mouse_pos = get_global_mouse_position()
	var parent_pos = get_parent().global_position
	
	move_direction = (mouse_pos - parent_pos).normalized()
	
	global_position = parent_pos + (move_direction * 10)
	
	look_at(global_position + move_direction)
	rotation += deg_to_rad(90)
	show()
	
func despawn() -> void:
	spawned = false
	hit = false
	reelAmount = 0
	for segment in ropeSegments:
		if is_instance_valid(segment):
			segment.queue_free()
	ropeSegments.clear()
	for joint in ropeJoints:
		if is_instance_valid(joint):
			joint.queue_free()
	ropeJoints.clear()
	hide()
	
func _process(delta: float) -> void:
	if !spawned:
		return
		
	if Input.is_action_just_pressed("ungraple"):
		despawn()
		return
	if Input.is_action_just_pressed("reelInGrapleHook"):
		reeling = true
	if Input.is_action_just_released("reelInGrapleHook"):
		reeling = false
		
	line.clear_points()
	var currentDistance = player.global_position.distance_to(global_position)

	if currentDistance > ropeLength * .99:
		line.add_point(player.global_position)
		line.add_point(global_position)
	else:
		for segment in ropeSegments:
			line.add_point(segment.global_position)
		
	if ropeSegments.size() > 0:
		ropeSegments[0].global_position = global_position
		ropeSegments[ropeSegments.size() - 1].global_position = player.global_position
	
	if reeling:
		reelAmount += 20
		ropeLength -= delta * 200
		if ropeLength < 50:
			ropeLength = 50


		
	if not hit:
		var collision = move_and_collide(move_direction * speed * delta)
		if collision:
			hit = true
			ropeLength = global_position.distance_to(player.global_position)
			global_position += move_direction * 10
			landingSound.pitch_scale = randf_range(0.7, 1.3)
			landingSound.play()
			var startPos = global_position
			var endPos = player.global_position
			var distance = startPos.distance_to(endPos)
			var direction = (endPos - startPos).normalized()
	
			var segmentSpacing = 20.0
			var numSegments = floor(distance / segmentSpacing)

			for i in range(numSegments):
				var segment
				var t = (float(i) + 0.5) / numSegments
				var position = startPos.lerp(endPos, t)
				if i == 0 or i == numSegments - 1:
					segment = ropeEnd.instantiate()
				else:
					segment = ropeSegment.instantiate()
				get_parent().add_child(segment)
				segment.top_level = true
				segment.global_position = position
				ropeSegments.append(segment)
				
			
			for i in range(ropeSegments.size() - 1):
				var currentSegment = ropeSegments[i]
				var nextSegment = ropeSegments[i + 1]
				var joint = PinJoint2D.new()
				joint.node_a = currentSegment.get_path()
				joint.node_b = nextSegment.get_path()
				currentSegment.add_child(joint)
				ropeJoints.append(joint)
