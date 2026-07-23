extends CollisionShape2D

@export var growthRateStart := 100.0
@export var growthRateGrowth := 1.005
@export var levelHeight := 1000.0
@export var levelLength := 1000.0
@export var waitPeriod := 5000

var startTime: int
var growthRate: float

func _ready() -> void:
	var rect := shape as RectangleShape2D
	rect.size.y = levelHeight
	startTime = Time.get_ticks_msec()
	growthRate = growthRateStart

func _process(delta: float) -> void:
	var rect := shape as RectangleShape2D
	if(startTime + waitPeriod < Time.get_ticks_msec() && levelLength > rect.size.x):
		rect.size += Vector2.RIGHT * growthRate * delta
		growthRate = growthRate * growthRateGrowth
