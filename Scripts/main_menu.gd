extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("start_game"):
		get_tree().change_scene_to_file("res://Scenes/main.tscn")

	if event.is_action_pressed("leave"):
		get_tree().quit()
