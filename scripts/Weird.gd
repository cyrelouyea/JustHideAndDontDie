extends Node2D

export var radius: float = 32.0
var rradius: float = 0.0

var timer: float = 0.0

func _process(delta):
	update()
	timer += delta
	rradius = lerp(rradius, radius, 8 * delta)
	material.set_shader_param("time", timer)
	

func _draw():
	draw_circle(
		Vector2(0, 0),
		rradius,
		Color(0, 0, 0, 0.8)
	)
