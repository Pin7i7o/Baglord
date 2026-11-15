extends Sprite2D

var speed: float = 0.0

func _process(delta: float) -> void:
	print(position)
	position.y += speed * delta
	
	if position.y > 400:
		queue_free()
