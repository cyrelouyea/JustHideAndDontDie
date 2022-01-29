extends Node2D


export var ps_level: PackedScene
export var ps_the_end: PackedScene

var levels = [
	{
		"nb_masks": 1,
		"key_to_collect": 0,
		"start_pos": Vector2(0, 160),
		"end_pos": Vector2(640, 160),
		"player_pos": Vector2(16, 160),
		"keys_pos": [],
		"enemies": [[0, Vector2(320, 80)]]
	},
	{
		"nb_masks": 1,
		"key_to_collect": 0,
		"start_pos": Vector2(0, 160),
		"end_pos": Vector2(640, 160),
		"player_pos": Vector2(16, 160),
		"keys_pos": [],
		"enemies": [[0, Vector2(180, 40)], [0, Vector2(180, 320-40)]]
	},
	{
		"nb_masks": 1,
		"key_to_collect": 1,
		"start_pos": Vector2(0, 160),
		"end_pos": Vector2(640, 160),
		"player_pos": Vector2(16, 160),
		"keys_pos": [Vector2(260, 40)],
		"enemies": [[0, Vector2(320, 40)]]
	},
	{
		"nb_masks": 0,
		"key_to_collect": 0,
		"start_pos": Vector2(0, 160),
		"end_pos": Vector2(640, 160),
		"player_pos": Vector2(16, 160),
		"keys_pos": [],
		"enemies": [[2, Vector2(320, 160)]]
	},
	{
		"nb_masks": 1,
		"key_to_collect": 2,
		"start_pos": Vector2(0, 160),
		"end_pos": Vector2(640, 160),
		"player_pos": Vector2(16, 160),
		"keys_pos": [Vector2(600, 40), Vector2(600, 280)],
		"enemies": [[2, Vector2(320, 40)], [2, Vector2(320, 280)]]
	},
	{
		"nb_masks": 1,
		"key_to_collect": 1,
		"start_pos": Vector2(0, 160),
		"end_pos": Vector2(640, 160),
		"player_pos": Vector2(16, 160),
		"keys_pos": [Vector2(320, 160)],
		"enemies": [[2, Vector2(400, 40)], [0, Vector2(400, 280)]]
	},
	{
		"nb_masks": 1,
		"key_to_collect": 1,
		"start_pos": Vector2(0, 160),
		"end_pos": Vector2(640, 160),
		"player_pos": Vector2(0, 160),
		"keys_pos": [Vector2(100, 40), Vector2(100, 280)],
		"enemies": [[0, Vector2(320, 40)], [1, Vector2(320, 280)]]
	},
	{
		"nb_masks": 0,
		"key_to_collect": 3,
		"start_pos": Vector2(320, 160),
		"end_pos": Vector2(320, 160),
		"player_pos": Vector2(320, 160),
		"keys_pos": [Vector2(40, 160), Vector2(600, 160), Vector2(320, 280)],
		"enemies": [[1, Vector2(320, 40)]]
	},
	{
		"nb_masks": 1,
		"key_to_collect": 2,
		"start_pos": Vector2(320, 160),
		"end_pos": Vector2(320, 160),
		"player_pos": Vector2(320, 160),
		"keys_pos": [Vector2(40, 160), Vector2(600, 160)],
		"enemies": [[1, Vector2(320, 40)], [1, Vector2(320, 280)]]
	},
	{
		"nb_masks": 2,
		"key_to_collect": 4,
		"start_pos": Vector2(320, 160),
		"end_pos": Vector2(320, 160),
		"player_pos": Vector2(320, 160),
		"keys_pos": [Vector2(40, 40), Vector2(600, 40), Vector2(40, 280), Vector2(600, 280)],
		"enemies": [[1, Vector2(320, 40)], [1, Vector2(320, 280)], [1, Vector2(40, 160)]]
	},
	{
		"nb_masks": 1,
		"key_to_collect": 2,
		"start_pos": Vector2(320, 160),
		"end_pos": Vector2(320, 160),
		"player_pos": Vector2(320, 160),
		"keys_pos": [Vector2(40, 160), Vector2(600, 160)],
		"enemies": [[2, Vector2(40, 40)], [2, Vector2(40, 280)], [2, Vector2(600, 40)], [2, Vector2(600, 280)]]
	},
	{
		"nb_masks": 1,
		"key_to_collect": 4,
		"start_pos": Vector2(320, 160),
		"end_pos": Vector2(320, 160),
		"player_pos": Vector2(320, 160),
		"keys_pos": [Vector2(40, 40), Vector2(600, 40), Vector2(40, 280), Vector2(600, 280)],
		"enemies": [[2, Vector2(320, 40)], [2, Vector2(320, 280)], [1, Vector2(40, 160)]]
	},
]

var current_instance = null
var current_level = 0

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _on_Level_restart():
	current_instance.queue_free()
	remove_child(current_instance)
	
	current_instance = ps_level.instance()
	init_instance(current_instance, current_level)
	
	add_child(current_instance)

func _on_Level_success():
	current_instance.queue_free()
	remove_child(current_instance)
	
	current_level += 1
	
	if current_level < levels.size():
		current_instance = ps_level.instance()
		init_instance(current_instance, current_level)
		add_child(current_instance)
	else:
		current_instance = ps_the_end.instance()
		add_child(current_instance)
	
	
func init_instance(instance: Node2D, level: int):
	instance.nb_masks = levels[level]["nb_masks"]
	instance.key_to_collect = levels[level]["key_to_collect"]
	instance.start_pos = levels[level]["start_pos"]
	instance.end_pos = levels[level]["end_pos"]
	instance.player_pos = levels[level]["player_pos"]
	instance.keys_pos = levels[level]["keys_pos"]
	instance.enemies = levels[level]["enemies"]
	instance.connect("restart", self, "_on_Level_restart")
	instance.connect("success", self, "_on_Level_success")


func _on_Tutorial_end_tutorial():
	$Tutorial.queue_free()
	remove_child($Tutorial)
	
	current_instance = ps_level.instance()
	init_instance(current_instance, current_level)
	add_child(current_instance)
