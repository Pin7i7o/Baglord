extends Node2D

signal update_score_signal
signal spawn_sprite_signal

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var monster_sprite_path = {
	GlobalVariables.TYPE_OF_MONSTER.ZOMBIE: "res://Assets/Monsters/zombie.png",
	GlobalVariables.TYPE_OF_MONSTER.MUMMY: "res://Assets/Monsters/mummy.png",
	GlobalVariables.TYPE_OF_MONSTER.SKELETON: "res://Assets/Monsters/skeleton.png",
	GlobalVariables.TYPE_OF_MONSTER.HUMAN: "res://Assets/Monsters/human.png",
}
var monster_points = {
	GlobalVariables.TYPE_OF_MONSTER.ZOMBIE: 50,
	GlobalVariables.TYPE_OF_MONSTER.MUMMY: 200,
	GlobalVariables.TYPE_OF_MONSTER.SKELETON: 500,
	GlobalVariables.TYPE_OF_MONSTER.HUMAN: -250,
}

var type_of_monster: GlobalVariables.TYPE_OF_MONSTER = GlobalVariables.TYPE_OF_MONSTER.ZOMBIE
var movement_height: int = 64
var can_hit: bool = false

func _ready() -> void:
	_change_monster_settings()
	randomize()

func _gen_type_of_monster() -> void:
	var rng = randi() % 1000
	
	if rng < 200:
		type_of_monster = GlobalVariables.TYPE_OF_MONSTER.MUMMY
	elif (rng >= 200 and rng < 600):
		type_of_monster = GlobalVariables.TYPE_OF_MONSTER.ZOMBIE
	elif (rng >= 600 and rng < 900):
		type_of_monster = GlobalVariables.TYPE_OF_MONSTER.HUMAN
	elif (rng >= 900 and rng < 1000):
		type_of_monster = GlobalVariables.TYPE_OF_MONSTER.SKELETON

func _change_monster_settings() -> void:
	_gen_type_of_monster()
	
	var texture = load(monster_sprite_path.get(type_of_monster))
	sprite_2d.texture = texture
	
	var new_time = _set_new_timer()
	timer.start(new_time)

func _set_new_timer() -> float:
	match type_of_monster:
		GlobalVariables.TYPE_OF_MONSTER.ZOMBIE: return 2.0
		GlobalVariables.TYPE_OF_MONSTER.MUMMY: return 1.5
		GlobalVariables.TYPE_OF_MONSTER.SKELETON: return 1.0
		GlobalVariables.TYPE_OF_MONSTER.HUMAN: return 2.5
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
		update_score_signal.emit(monster_points.get(type_of_monster), type_of_monster)
		spawn_sprite_signal.emit(monster_sprite_path.get(type_of_monster))
		can_hit = false
		audio_stream_player.play()
		_movement(Vector2.DOWN, true, true)

func _movement(direction: Vector2, disable_collision: bool, change_settings: bool) -> void:
	collision_shape_2d.disabled = disable_collision
	
	global_position += direction * movement_height
	
	if change_settings:
		_change_monster_settings()
