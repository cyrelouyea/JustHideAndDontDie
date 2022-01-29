extends Area2D

signal collect_key

func _on_Key_area_entered(area):
	emit_signal("collect_key")
	queue_free()

