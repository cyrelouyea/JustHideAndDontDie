extends Node2D

signal kill
signal hidden(value)

export var speed: float = 100.0
export var hidden: bool = false

var velocity = Vector2(0, 0)
var mask_stack = 0
var inner_pos = Vector2(0, 0)


func _ready():
	pass


func _process(delta):
	velocity = Vector2(0, 0)
	inner_pos = Vector2(0, 0)
	
	if Input.is_action_pressed("up"):
		velocity.y = -1
		inner_pos.y = -1
	elif Input.is_action_pressed("down"):
		velocity.y = 1 
		inner_pos.y = 1
	
	if Input.is_action_pressed("right"):
		velocity.x = 1
		inner_pos.x = 1
	elif Input.is_action_pressed("left"):
		velocity.x = -1
		inner_pos.x = -1
		
	position += velocity.normalized() * speed * delta
	
	position.x = clamp(position.x, 8, 640-8)
	position.y = clamp(position.y, 8, 320-8)
	
	$Inner.position = lerp($Inner.position, inner_pos.normalized() * 12, 12 * delta)


func _on_Player_area_entered(area):
	if area.is_in_group("enemy"):
		emit_signal("kill")
	elif area.is_in_group("mask"):
		mask_stack += 1
		if mask_stack > 0:
			emit_signal("hidden", true)


func _on_Player_area_exited(area):
	if area.is_in_group("enemy"):
		pass
	elif area.is_in_group("mask"):
		mask_stack -= 1
		if mask_stack <= 0:
			emit_signal("hidden", false)


func is_hidden():
	return mask_stack > 0


func kill():
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	set_process(false)
	
func deactivate():
	$CollisionShape2D.set_deferred("disabled", true)
	
