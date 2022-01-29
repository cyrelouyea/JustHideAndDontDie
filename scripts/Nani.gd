extends Sprite

var timer = 0

func _ready():
	scale = Vector2(3.0, 3.0)
	modulate.a = 0.0

	
func _process(delta):
	scale.x = max(scale.x - 15 * delta, 1.0)
	scale.y = max(scale.y - 15 * delta, 1.0)
	modulate.a = min(modulate.a + 5 * delta, 1)
	
	if timer >= 0.4:
		queue_free()
	
	timer += delta
	
	update()
	
	
func _draw():
	draw_arc(
		Vector2(0, 0), timer * 200, 0, PI * 2, 16, Color(1.0, 0.0, 0.0, 1.0 - 2 * timer), 3.0 - 5.0 * timer
	)

