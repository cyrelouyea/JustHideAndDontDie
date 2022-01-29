extends Node2D


export var speed: float
export var angle: float


func _process(delta):
	position.x += speed * cos(angle - PI/2) * delta
	position.y += speed * sin(angle - PI/2) * delta
	
	if position.x < -32 or position.x > 640 + 32 or position.y < -32 or position.y > 320 + 32:
		queue_free()
	

	


