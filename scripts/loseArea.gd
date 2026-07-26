extends Area2D

@export var particles: CPUParticles2D
@export var playerBodyName: String = "Player"
@export var growthTime: float = 15000.0
@export var levelLength: float = 2000.0
@export var waitPeriod: float = 1000
@export var startWidth: float = 0.0
@export var colorRect: ColorRect

var elapsedTime: float = 0.0
var isWaiting: bool = true
var isGrowing: bool = false
var growthProgress: float = 0.0

func _ready() -> void:
	levelLength *= 2
	$CollisionShape2D.shape.size.x = startWidth

func _process(delta: float) -> void:
	var deltaMs: float = delta * 1000.0
	
	if isWaiting:
		elapsedTime += deltaMs
		if elapsedTime >= waitPeriod:
			isWaiting = false
			isGrowing = true
			elapsedTime = 0.0
			growthProgress = 0.0
			particles.emitting = true
		return

	if isGrowing:
		elapsedTime += deltaMs
		
		growthProgress = elapsedTime / growthTime
		
		if growthProgress >= 1.0:
			growthProgress = 1.0
			isGrowing = false
		
		var easedProgress: float = (exp(growthProgress * 10.0) - 1.0) / (exp(10.0) - 1.0)
		var currentWidth: float = startWidth + (levelLength - startWidth) * easedProgress
		
		$CollisionShape2D.shape.size.x = currentWidth
		
		if colorRect:
			colorRect.size.x = currentWidth / 2
			particles.position.x = colorRect.size.x


func _on_body_entered(body: Node2D) -> void:
	if body.name == playerBodyName:
		GlobalEventBus.playerDeath.emit()
		
		
func reset_all(new_growth_time: float) -> void:
	growthTime = new_growth_time
	
	elapsedTime = 0.0
	isWaiting = true
	isGrowing = false
	growthProgress = 0.0
	
	particles.emitting = false
	
	$CollisionShape2D.shape.size.x = startWidth
	
	if colorRect:
		colorRect.size.x = startWidth / 2
		particles.position.x = colorRect.size.x
	if colorRect:
		colorRect.size.x = startWidth / 2
		particles.position.x = colorRect.size.x
