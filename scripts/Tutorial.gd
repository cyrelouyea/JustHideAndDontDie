extends Node2D

signal end_tutorial

export var ps_mask: PackedScene
export var nb_masks: int

var player_hidden = false
var energy = 1.0

func _ready():
	$Battery.set_nb_masks(nb_masks)

func _process(delta):
	if Input.is_action_just_pressed("click") and can_spawn_mask():
		spawn_mask(get_viewport().get_mouse_position())
		
	if Input.is_action_just_pressed("space"):
		emit_signal("end_tutorial")
		
	$Light2D.energy = lerp($Light2D.energy, energy, 15 * delta)

func spawn_mask(pos: Vector2):
	var instance = ps_mask.instance()
	instance.position = pos
	instance.player_hidden(player_hidden)
	$Masks.add_child(instance)
	nb_masks -= 1
	$Battery.set_nb_masks(nb_masks)

func can_spawn_mask():
	return nb_masks > 0
	
func _on_Player_hidden(value):
	if value:
		energy = 0.0
	else:
		energy = 1.2
	
	player_hidden = value
	for mask in $Masks.get_children():
		mask.player_hidden(value)
		

func _on_Key_collect_key():
	$Collect.play()
