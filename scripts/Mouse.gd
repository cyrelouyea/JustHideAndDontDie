extends Node2D

export var randomness: int

onready var queue_lines = [get_viewport().get_mouse_position()]
const QUEUE_SIZE = 25



func _process(delta):
	queue_lines.push_back(get_viewport().get_mouse_position() + Vector2(rand_range(-randomness, randomness), rand_range(-randomness, randomness)))
	if queue_lines.size() > QUEUE_SIZE:
		queue_lines.pop_front()
		
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	update()


func _draw():
	for i in range(queue_lines.size() - 1):
		draw_line(
			queue_lines[i],
			queue_lines[i + 1],
			Color(0.0, 0.0, 1.0, 0.0 + float(i) / float(queue_lines.size())),
			1 + 2*float(i) / float(queue_lines.size())
		)
