extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D

var number_of: int = 0
var type_of: int = 0
	#1 - zombie | 2- mummy | 3 skeleton

func _ready() -> void:
	_set_number_of_occupants()
	_set_correspondant_sprite()
	
func _set_number_of_occupants() -> void:
	number_of = randi_range(1, 5)
	type_of = randi_range(1, 3)

func _set_correspondant_sprite() -> void:
	match type_of:
		1:
			animated_sprite_2d.play("mummy")
		2:
			animated_sprite_2d.play("zombie")
		3:
			animated_sprite_2d.play("skeleton")
			
			
			
			
			
			
