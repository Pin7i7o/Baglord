extends Sprite2D

var speed: int = 0

func _process(delta: float) -> void:
	position.y += speed * delta
	
	if position.y > get_viewport_rect().size.y + 64:
		queue_free()
