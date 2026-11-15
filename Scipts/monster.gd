extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer

enum TYPE_OF_MONSTER {
	ZOMBIE,
	MUMMY,
	SKELETON,
	HUMAN
}

var monster_sprite_path = {
	TYPE_OF_MONSTER.ZOMBIE: "res://Assets/Monsters/zombie.png",
	TYPE_OF_MONSTER.MUMMY: "res://Assets/Monsters/mummy.png",
	TYPE_OF_MONSTER.SKELETON: "res://Assets/Monsters/skeleton.png",
	TYPE_OF_MONSTER.HUMAN: "res://Assets/Monsters/human.png",
}
var monster_points = {
	TYPE_OF_MONSTER.ZOMBIE: 50,
	TYPE_OF_MONSTER.MUMMY: 200,
	TYPE_OF_MONSTER.SKELETON: 500,
	TYPE_OF_MONSTER.HUMAN: -250,
}

var type_of_monster: TYPE_OF_MONSTER = TYPE_OF_MONSTER.ZOMBIE
var movement_height: int = 64
var can_hit: bool = false
var initial_position: Vector2 = Vector2.ZERO


func _ready() -> void:
	initial_position = global_position
	_gen_type_of_monster()
	_set_monster_sprite()

func _set_monster_sprite() -> void:
	var texture = load(monster_sprite_path.get(type_of_monster))
	sprite_2d.texture = texture
	
func _gen_type_of_monster() -> void:
	var rng = randi() % 1000
	print(rng)
	
	if rng < 200:
		type_of_monster = TYPE_OF_MONSTER.MUMMY
	elif (rng >= 200 and rng < 600):
		type_of_monster = TYPE_OF_MONSTER.ZOMBIE
	elif (rng >= 600 and rng < 900):
		type_of_monster = TYPE_OF_MONSTER.HUMAN
	elif (rng >= 900 and rng < 1000):
		type_of_monster = TYPE_OF_MONSTER.SKELETON
		
		
		
		
