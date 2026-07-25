extends Area2D

@export var playerBodyName:String = "Player"
@export var growthRateStart:float = 100.0
@export var growthTime:float = 15000.0
@export var levelLength:float = 1000.0
@export var waitPeriod:float = 5000
@export var startWidth:float = 0.0

func _ready() -> void:
	$CollisionShape2D.shape.size.x = startWidth
	await get_tree().create_timer(waitPeriod / 1000.0).timeout
	var tween = create_tween()
	tween.tween_property(
		$CollisionShape2D.shape,
		"size:x",
		levelLength,
		growthTime / 1000.0
	).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)

func _on_body_entered(body:Node2D):
	if (body.name == playerBodyName):
		GlobalEventBus.playerDeath.emit()
