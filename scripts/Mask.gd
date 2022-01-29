extends Node2D

export var ps_circle_trail: PackedScene
export var color: Color
export var radius: float = 32.0
var rradius: float = 0.0

var energy = 1.0


func _process(delta):
	$CollisionShape2D.shape.radius = rradius
	rradius = lerp(rradius, radius, 8 * delta) 
	$Light2D.energy = lerp($Light2D.energy, energy, 15 * delta)
	$Light2D.texture_scale = rradius / 28
	$Weird.rradius = rradius 
	$Trails.rradius = rradius - 2
	$Trails.color = color
	

		
func player_hidden(value: bool):
	if value:
		energy = 1.1
	else:
		energy = 0.0


func _on_Mask_area_entered(area):
	if area.is_in_group("player"):
		spawn_trail()
		
		
func spawn_trail():
	var instance = ps_circle_trail.instance()
	instance.color = color
	instance.radius = radius
	add_child(instance)
