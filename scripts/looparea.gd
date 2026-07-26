extends Area2D

@export var playerBodyName:String = "Player"
@export var loseArea:Area2D
@export var timer:HBoxContainer
@export var label:Label

var startTime = 25
var loopCount = 0

func _on_body_entered(body:Node2D):
	if (body.name == playerBodyName):
		body.despawn()
		body.position.x -= 8160
		body.position.y -= 384
		startTime -= 3
		loopCount += 1
		label.text = "LoopCount:" + str(loopCount)
		loseArea.reset_all(max(5000,startTime*1000))
		timer.startTime = 5 + startTime
		timer.timeRemaining = timer.startTime
	
