extends Node2D

@onready var score_label: Label = $ScoreLabel
@onready var monsters: Node2D = $Monsters
@onready var monsters_sprites: Node2D = $MonstersSprites

var score: int = 0
var spawned_monster_scene = preload("res://Scenes/spawned_monster.tscn")

func _ready() -> void:
	score_label.text = ("Score: 0")

	for monster in monsters.get_children():
		monster.update_score_signal.connect(_update_score)
		monster.spawn_sprite_signal.connect(_spawn_sprite)

func _generate_random_poisition() -> Vector2:
	var rng_x = randf_range(832, 1152)
	var rng_y = randf_range(64, 320)
	
	return Vector2(rng_x, rng_y)

func _update_score(points: int) -> void:
	if (score + points) < 0:
		score = 0
	else:
		score+= points

func _spawn_sprite(sprite_path: String) -> void:
	var new_monster_instance = spawned_monster_scene.instantiate()

	new_monster_instance.get_child(1).texture = load(sprite_path)
	
	new_monster_instance.global_position = Vector2(randf_range(832, 1152), randf_range(64, 320))
	new_monster_instance.rotation_degrees = randi() % 361
	new_monster_instance.speed = randf_range(150, 300)
	
	monsters_sprites.add_child(new_monster_instance)
	
