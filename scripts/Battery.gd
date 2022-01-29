extends Node2D


export var nb_masks: int
var timer: float = 0.0


func _process(delta):
	if nb_masks <= 0:
		if timer <= 0.8:
			modulate.a = 1.0
		elif timer <= 1.2:
			modulate.a = 0.0
		else:
			timer -= 1.2
		timer += delta
		
func set_nb_masks(nb: int):
	nb_masks = nb
	if nb >= 3:
		$Battery1.show()
		$Battery2.show()
		$Battery3.show()
	elif nb == 2:
		$Battery1.show()
		$Battery2.show()
		$Battery3.hide()
	elif nb == 1:
		$Battery1.show()
		$Battery2.hide()
		$Battery3.hide()
		modulate = Color.yellow
	else:
		$Battery1.hide()
		$Battery2.hide()
		$Battery3.hide()
		modulate = Color.red
		
	
