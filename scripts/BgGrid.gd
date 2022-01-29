extends Node2D

export var h_bg_line: PackedScene
export var v_bg_line: PackedScene

const nb_h_lines = 16
const sq_size = 320 / nb_h_lines
const nb_v_lines = 640 / sq_size

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(nb_h_lines):
		var line = h_bg_line.instance()
		line.position = Vector2(0, sq_size/2.0 + i*sq_size)
		line.offset = i * PI / nb_h_lines
		add_child(line)
	
	for i in range(nb_v_lines):
		var line = v_bg_line.instance()
		line.position = Vector2(sq_size/2.0 + i*sq_size, 0)
		line.offset = i * PI / nb_h_lines
		add_child(line)
