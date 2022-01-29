

extends Area2D

export var ps_nani: PackedScene
export var speed: float = 125.0

const lag = 0.15

var player: Node2D
var velocity = Vector2(0.0, 0.0)
var angle = 0.0
var mask_stack = 0
var tlag = lag
var fl_p_hidden = true
var timer = 0
var tst = 0.1

func _process(delta):
	
	if tst >= 0.0:
		tst -=delta
		return
		
	velocity = lerp(velocity, Vector2(0, 0), 20 * delta)
	
	if not player.is_hidden() or is_in_mask(): # and not is_in_mask():
		tlag -= delta
		angle = position.angle_to_point(player.position)
		$Sprites.rotation = lerp($Sprites.rotation, angle - PI/2, delta * 8) 
	else:
		tlag = lag
	
	if fl_p_hidden and (not player.is_hidden() or is_in_mask()):
		fl_p_hidden = false
		spawn_nani()
	elif not fl_p_hidden and not (not player.is_hidden() or is_in_mask()):
		fl_p_hidden = true
		
	if tlag < 0:
		velocity = Vector2(1, 1) * speed
		
	position += Vector2(
		velocity.x * -cos(angle),
		velocity.y * -sin(angle)
	) * delta
	
	$Sprites/Sprite.scale = Vector2(1, 1) + Vector2(1, 1) * 0.07 * cos(timer * 6)
	$Sprites/Sprite2.scale = Vector2(1, 1) + Vector2(1, 1) * 0.08 * cos(timer * 9)
	
	timer += delta


func _on_Enemy_area_entered(area: Area2D):
	if area.is_in_group("player"):
		pass
	elif area.is_in_group("mask"):
		mask_stack += 1


func _on_Enemy_area_exited(area):
	if area.is_in_group("player"):
		pass
	elif area.is_in_group("mask"):
		mask_stack -= 1
		

func is_in_mask():
	return mask_stack > 0


func spawn_nani():
	var instance = ps_nani.instance()
	instance.position = Vector2(0, -32)
	add_child(instance)
	$AudioStreamPlayer.play()
	
	
func kill():
	set_process(false)
	hide()
