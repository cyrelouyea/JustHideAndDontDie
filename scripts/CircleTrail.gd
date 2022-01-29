extends Node2D

export var radius: float
export var color: Color

var timer = 0

func _process(delta):	
	
	if timer >= 0.5:
		queue_free()
	
	update()
	timer += delta
	
	
func _draw():
	draw_arc(Vector2(0, 0), radius + 100 * timer, 0, PI * 2, 20, Color(color.r, color.g, color.b, 1.0 - timer * 2), 3.0 - timer  * 3)
