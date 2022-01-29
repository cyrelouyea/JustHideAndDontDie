extends Node2D


var timer = 0
var speed = 4

func _process(delta):
	update()
	timer += delta


func _draw():
	draw_polygon(
		PoolVector2Array([ 
			Vector2(-6 + cos(1.3 + speed * timer * 3), 0 + sin(1.3 + speed * timer * 2.7)),
			Vector2(0  + cos(1.3 + speed * timer * 2.4), -6 + sin(1.3 + speed * timer * 3.3)),
			Vector2(6 + cos(1.3 + speed * timer * 3.4), 0 + sin(1.3 + speed * timer * 2.9)),
			Vector2(0 + cos(1.3 + speed * timer * 3.1), 6 + sin(1.3 + speed * timer * 3.6)),
		]),
		PoolColorArray([
			Color(1.0, 1.0, 0.2, 0.8),
			Color(1.0, 1.0, 0.2, 0.8),
			Color(1.0, 1.0, 0.2, 0.8),
			Color(1.0, 1.0, 0.2, 0.8),
		])
	)
	
	draw_arc(
		Vector2(0, 0),
		9 + 2 * cos(speed * timer),
		0, PI * 2, 6, Color(1.0, 1.0, 0.2, 0.8 + 0.2 * cos(speed * timer * 1.5))
	)

