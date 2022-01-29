extends Node2D


export var color: Color
export var rradius: float = 0.0

const nb_trails: int = 10
const step: float = 1.2*PI / nb_trails
const dist_trail: float = 10.0
var timer: float = 0.0
var speed: float = 4.0

func _process(delta):
	update()
	timer += delta
	
func _draw():
	for i in nb_trails:
		var t = dist_trail/2 * cos(timer * speed + i * step)
		draw_arc(
			Vector2(0, 0),
			rradius+dist_trail/2+t,
			0,
			2 * PI,
			24,
			Color(color.r, color.g, color.b, 0.5 - 0.5 * cos(timer * speed + i * step)),
			1,
			false
		)
