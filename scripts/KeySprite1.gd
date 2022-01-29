extends Node2D


var timer = 0
var speed = 5

func _process(delta):
	update()
	timer += delta


func _draw():
	draw_polygon(
		PoolVector2Array([ 
			Vector2(-4 + cos(speed * timer * 3), -4 + sin(speed * timer * 2.7)),
			Vector2(4  + cos(speed * timer * 2.4), -4 + sin(speed * timer * 3.3)),
			Vector2(4 + cos(speed * timer * 3.4), 4 + sin(speed * timer * 2.9)),
			Vector2(-4 + cos(speed * timer * 3.1), 4 + sin(speed * timer * 3.6)),
		]),
		PoolColorArray([
			Color(1.0, 1.0, 0.2, 0.8),
			Color(1.0, 1.0, 0.2, 0.8),
			Color(1.0, 1.0, 0.2, 0.8),
			Color(1.0, 1.0, 0.2, 0.8),
		])
	)


