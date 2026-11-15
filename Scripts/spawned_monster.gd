extends Area2D

var speed: float = 0.0

func _process(delta: float) -> void:
	position.y += speed * delta
