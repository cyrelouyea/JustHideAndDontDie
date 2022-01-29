extends Sprite

var timer = 0

func _ready():
	scale = Vector2(0.0, 0.0)
	modulate.a = 0.0
	
func _process(delta):
	
	
	if timer <= 0.4:
		scale.x = min(scale.x + 5 * delta, 1.0)
		scale.y = min(scale.y + 5 * delta, 1.0)
		modulate.a = min(modulate.a + 5 * delta, 1)
		rotation_degrees = 15* cos(timer * 10)
	elif timer <= 0.8:
		scale.x = max(scale.x - 5 * delta, 0.0)
		scale.y = max(scale.y - 5 * delta, 0.0)
		rotation_degrees = 15* cos(timer * 10)
	elif timer >= 1.2:
		queue_free()
	
	timer += delta
	
	
