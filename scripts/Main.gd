extends Node2D

signal restart
signal success

export var ps_mask: PackedScene
export var ps_key: PackedScene
export(Array, PackedScene) var ps_enemies: Array

export var nb_masks: int
export var key_to_collect: int
export var start_pos: Vector2
export var end_pos: Vector2
export var player_pos: Vector2
export var keys_pos: Array
export var enemies: Array

var energy = 0.0
var player_hidden = true
var can_finish: bool = false

var aberration = 0.0
var boost = 1.0
var screen_shake = Vector2(0, 0)
var screen_shake_time = 0

var next_level_in = 0
var success = false
var game_over = false

func _ready():
	can_finish = key_to_collect <= 0
	update_mission()
	$Light2D.energy = 0
	$Masks/Start.position = start_pos
	$Masks/End.position = end_pos
	$Player.position = player_pos
	$Battery.set_nb_masks(nb_masks)
	
	for pos in keys_pos:
		var instance = ps_key.instance()
		instance.position = pos
		instance.connect("collect_key", self, "_on_Key_collect_key")
		$Keys.add_child(instance)
		
	for enemy in enemies:
		var instance = ps_enemies[enemy[0]].instance()
		instance.position = enemy[1]
		instance.player = $Player
		$Enemies.add_child(instance)


func _process(delta):
	if Input.is_action_just_pressed("click") and can_spawn_mask():
		spawn_mask(get_viewport().get_mouse_position())

	if not success and Input.is_action_just_pressed("restart"):
		emit_signal("restart")
	
	if screen_shake_time >= 0:
		screen_shake = 1.5 * Vector2(rand_range(-0.01, 0.01), rand_range(-0.01, 0.01))
		screen_shake_time -= delta
	else:
		screen_shake = Vector2(0, 0)
	
	$Light2D.energy = lerp($Light2D.energy, energy, 15 * delta)
	
	$CanvasLayer/ColorRect.material.set_shader_param("boost", boost)
	$CanvasLayer/ColorRect.material.set_shader_param("aberration_amount", aberration)
	$CanvasLayer/ColorRect.material.set_shader_param("screen_shake", screen_shake)
	
	if success:
		if next_level_in <= 0:
			set_process(false)
			emit_signal("success")
		next_level_in -= delta
		$GG/NextLevelLabel.text = "Next mission in " + str(int(next_level_in) + 1)
	
	can_finish = key_to_collect <= 0

func spawn_mask(pos: Vector2):
	var instance = ps_mask.instance()
	instance.position = pos
	instance.player_hidden(player_hidden)
	$Masks.add_child(instance)
	nb_masks -= 1
	$Battery.set_nb_masks(nb_masks)
	
func can_spawn_mask():
	return nb_masks > 0

func game_over():
	_on_Player_hidden(false)
	$Player.kill()
	$GameOver.show()
	screen_shake_time = 0.1
	aberration = 1.5
	boost = 1.5
	game_over = true
	
func level_complete():
	_on_Player_hidden(false)
	$Player.deactivate()
	$GG.show()
	boost = 1.5
	aberration = 1.5
	success = true
	for enemy in $Enemies.get_children():
		enemy.kill()
	next_level_in = 3
	$Success.play()
	

func _on_Player_kill():
	$AudioStreamPlayer.play()
	game_over()


func _on_Player_hidden(value):
	if value:
		energy = 0.0
	else:
		energy = 1.2
	
	player_hidden = value
	for mask in $Masks.get_children():
		mask.player_hidden(value)


func _on_Key_collect_key():
	key_to_collect -= 1
	update_mission()
	$Collect.play()

func update_mission():
	print(key_to_collect)
	if key_to_collect > 1:
		$Mission.text = "Collect " + str(key_to_collect) + " keys"
		$Mission.add_color_override("font_color", Color(1.0, 1.0, 0.0, 1.0))
	elif key_to_collect == 1:
		$Mission.text = "Collect 1 key"
		$Mission.add_color_override("font_color", Color(1.0, 1.0, 0.0, 1.0))
	else:
		$Mission.text = "Escape!"
		$Mission.add_color_override("font_color", Color(0.0, 1.0, 0.0, 1.0))

func _on_End_area_entered(area):
	if can_finish:
		level_complete()
