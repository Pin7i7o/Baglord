extends Node2D

@onready var monsters: Node2D = $Monsters
@onready var monsters_sprites: Node2D = $MonstersSprites
@onready var timer: Timer = $Timer
@onready var timer_label: Label = $TimerLabel
@onready var score_label: Label = $ScoreLabel

var spawned_monster_scene:PackedScene  = preload("res://Scenes/spawned_monster.tscn")
var game_over_scene:PackedScene  = preload("res://Scenes/game_over.tscn")

func _ready() -> void:
	for monster in monsters.get_children():
		monster.update_score_signal.connect(_update_score)
		monster.spawn_sprite_signal.connect(_spawn_sprite)

func _process(_delta: float) -> void:
	timer_label.text = str(ceil(timer.time_left))
	score_label.text = "Score: " + str(GlobalVariables.score)

func _generate_random_poisition() -> Vector2:
	var rng_x = randf_range(832, 1152)
	var rng_y = randf_range(64, 320)
	
	return Vector2(rng_x, rng_y)

func _update_score(points: int, type_of_monster: GlobalVariables.TYPE_OF_MONSTER) -> void:
	var new_death_counter = GlobalVariables.monster_deaths.get(type_of_monster)
	GlobalVariables.monster_deaths.set(type_of_monster, new_death_counter + 1)
	
	GlobalVariables.score += points

func _spawn_sprite(sprite_path: String) -> void:
	var new_monster_instance = spawned_monster_scene.instantiate()

	new_monster_instance.get_child(1).texture = load(sprite_path)
	
	new_monster_instance.global_position = Vector2(randf_range(832, 1152), randf_range(64, 320))
	new_monster_instance.rotation_degrees = randi() % 361
	new_monster_instance.speed = randf_range(150, 300)
	
	monsters_sprites.add_child(new_monster_instance)
	
func _on_timer_timeout() -> void:
	timer_label.text = str(0.0)
	get_tree().paused = true
	
	var game_over_scene_instance = game_over_scene.instantiate()
	get_tree().get_root().add_child(game_over_scene_instance)
