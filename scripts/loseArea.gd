extends Area2D

@export var playerBodyName:String = "Player"
@export var growthRateStart:float = 100.0
@export var growthRateGrowth:float = 1.01
@export var levelLength:float = 1000.0
@export var waitPeriod:float = 5000

var startTime: int
var growthRate: float

func _ready() -> void:
	startTime = Time.get_ticks_msec()
	growthRate = growthRateStart

func _process(delta: float) -> void:
	var rect = $CollisionShape2D.shape
	if(startTime + waitPeriod < Time.get_ticks_msec() && levelLength > rect.size.x):
		rect.size += Vector2.RIGHT * growthRate * delta
		growthRate = growthRate * growthRateGrowth

func _on_body_entered(body:Node2D):
	if (body.name == playerBodyName):
		GlobalEventBus.playerDeath.emit()
