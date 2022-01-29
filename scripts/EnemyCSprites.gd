extends Node2D

var timer = 0

func _process(delta):
	$Sprite.scale = Vector2(1, 1) + Vector2(0.03, 0.03) * cos(timer * 5)
	$Sprite2.scale = Vector2(1, 1) + Vector2(0.05, 0.05) * sin(timer * 8)
	timer += delta


