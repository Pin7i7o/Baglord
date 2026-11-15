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
var sprite_node_positon_tween: Tween


func _ready() -> void:
	initial_position = global_position
	_change_monster_settings()
	randomize()

func _gen_type_of_monster() -> void:
	var rng = randi() % 1000
	
	if rng < 200:
		type_of_monster = TYPE_OF_MONSTER.MUMMY
	elif (rng >= 200 and rng < 600):
		type_of_monster = TYPE_OF_MONSTER.ZOMBIE
	elif (rng >= 600 and rng < 900):
		type_of_monster = TYPE_OF_MONSTER.HUMAN
	elif (rng >= 900 and rng < 1000):
		type_of_monster = TYPE_OF_MONSTER.SKELETON

func _change_monster_settings() -> void:
	_gen_type_of_monster()
	
	var texture = load(monster_sprite_path.get(type_of_monster))
	sprite_2d.texture = texture
	
	var new_time = _set_new_timer()
	timer.start(new_time)

func _set_new_timer() -> float:
	match type_of_monster:
		TYPE_OF_MONSTER.ZOMBIE: return 2.0
		TYPE_OF_MONSTER.MUMMY: return 1.5
		TYPE_OF_MONSTER.SKELETON: return 1.0
		TYPE_OF_MONSTER.HUMAN: return 2.0
		_: return 0.0

func _on_timer_timeout() -> void:
	if can_hit == false:
		can_hit = true
		_movement(Vector2.UP, false, false)
	elif can_hit == true:
		can_hit = false
		_movement(Vector2.DOWN, true, true)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("click") and can_hit:
		can_hit = false
		_movement(Vector2.DOWN, true, true)

func _movement(direction: Vector2, disable_collision: bool, change_settings: bool) -> void:
	collision_shape_2d.disabled = disable_collision
	
	global_position += direction * movement_height
	
	if change_settings:
		_change_monster_settings()
