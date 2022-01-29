extends Node2D

export var ss = 3

var timer = 0
var speed = 5

func _process(delta):
	update()
	timer += delta


func _draw():
	draw_polygon(
		PoolVector2Array([ 
			Vector2(-ss + cos(speed * timer * 3), -ss + sin(speed * timer * 2.7)),
			Vector2(ss + cos(speed * timer * 2.4), -ss + sin(speed * timer * 3.3)),
			Vector2(ss + cos(speed * timer * 3.4), ss + sin(speed * timer * 2.9)),
			Vector2(-ss + cos(speed * timer * 3.1), ss + sin(speed * timer * 3.6)),
		]),
		PoolColorArray([
			Color(1.0, 0.8, 0.8, 0.5),
			Color(1.0, 0.8, 0.8, 0.5),
			Color(1.0, 0.8, 0.8, 0.5),
			Color(1.0, 0.8, 0.8, 0.5),
		])
	)
