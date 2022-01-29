extends Node2D


var ss = 5
var timer = 0
var speed = 5

func _process(delta):
	update()
	timer += delta


func _draw():
	draw_polygon(
		PoolVector2Array([ 
			Vector2(0 + cos(1.2 + speed * timer * 3), -ss + sin(1.2 + speed * timer * 2.7)),
			Vector2(-ss + cos(1.2 + speed * timer * 2.4), 0 + sin(1.2 + speed * timer * 3.3)),
			Vector2(0 + cos(1.2 + speed * timer * 3.4), ss + sin(1.2 + speed * timer * 2.9)),
			Vector2(ss + cos(1.2 + speed * timer * 3.1), 0 + sin(1.2 + speed * timer * 3.6)),
		]),
		PoolColorArray([
			Color(1.0, 0.2, 0.2, 0.8),
			Color(1.0, 0.2, 0.2, 0.8),
			Color(1.0, 0.2, 0.2, 0.8),
			Color(1.0, 0.2, 0.2, 0.8),
		])
	)
