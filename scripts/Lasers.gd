extends Node2D

var mscale = 0.0
var timer = 0


func _process(delta):
	$Laser1/Sprite1.scale.x = 1 +  0.2 * cos(timer * 4)
	$Laser1/Sprite2.scale.x = 0.7 +  0.3 * sin(1.5+timer * 12)
	
	$Laser2/Sprite1.scale.x = 1 +  0.2 * cos(timer * 4)
	$Laser2/Sprite2.scale.x = 0.7 +  0.3 * sin(1.5+timer * 12)
	
	$Laser1.scale.x = lerp($Laser1.scale.x, mscale, delta * 12)
	$Laser2.scale.x = lerp($Laser2.scale.x, mscale, delta * 12)
	
	timer += delta


func activate(b: bool):
	if b:
		mscale = 0.60
		$Laser1.collision_layer = 4
		$Laser2.collision_layer = 4
	else:
		mscale = 0.0
		$Laser1.collision_layer = 0
		$Laser2.collision_layer = 0
