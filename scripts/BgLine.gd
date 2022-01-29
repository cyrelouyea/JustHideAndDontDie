extends Node2D

export var offset: float = 0
export var speed: float = 3

var timer: float = 0


func _ready():
	pass


func _process(delta):
	modulate.a = 0.75 + 0.25 * cos(timer * 3 + offset)
	timer += delta
