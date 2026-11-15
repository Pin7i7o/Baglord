extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _on_area_entered(area: Area2D) -> void:
	area.queue_free()
	animated_sprite_2d.play("eat")
	audio_stream_player.play()
