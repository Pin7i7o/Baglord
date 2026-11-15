extends Control

@onready var timer: Timer = $Timer
@onready var sprites: Node2D = $Sprites

var sprite_paths: Array[String] = [
	"res://Assets/Monsters/zombie.png",
	"res://Assets/Monsters/mummy.png",
	"res://Assets/Monsters/skeleton.png",
	"res://Assets/Monsters/human.png"
]

var spawned_sprite_scene:PackedScene = preload("res://Scenes/menu_rain.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("start_game"):
		get_tree().change_scene_to_file("res://Scenes/main.tscn")

	if event.is_action_pressed("leave"):
		get_tree().quit()

func _on_timer_timeout() -> void:
	_spawn_sprite(sprite_paths.pick_random())
	
func _spawn_sprite(sprite_path: String) -> void:
	var screen_size = get_viewport_rect().size
	var new_sprite_instance = spawned_sprite_scene.instantiate()

	new_sprite_instance.texture = load(sprite_path)
	new_sprite_instance.position = Vector2(randf_range(0, screen_size.x), -64)
	new_sprite_instance.rotation_degrees = randi() % 361
	new_sprite_instance.speed = randf_range(100, 150)
	
	sprites.add_child(new_sprite_instance)
	
	
	
	
