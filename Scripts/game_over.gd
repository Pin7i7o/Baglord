extends CanvasLayer

@onready var score: Label = $ColorRect/VBoxContainer/Score

@onready var zombie_label: Label = $ColorRect/VBoxContainer/HBoxContainer/ZombieLabel
@onready var mummy_label: Label = $ColorRect/VBoxContainer/HBoxContainer2/MummyLabel
@onready var skeleton_label: Label = $ColorRect/VBoxContainer/HBoxContainer3/SkeletonLabel
@onready var human_label: Label = $ColorRect/VBoxContainer/HBoxContainer4/HumanLabel

func _ready() -> void:
	score.text = "Your score: " + str(GlobalVariables.score)
	
	zombie_label.text = str(GlobalVariables.monster_deaths.get(GlobalVariables.TYPE_OF_MONSTER.ZOMBIE)) + " killed!!!"
	mummy_label.text =  str(GlobalVariables.monster_deaths.get(GlobalVariables.TYPE_OF_MONSTER.MUMMY)) + " killed!!!"
	skeleton_label.text = str(GlobalVariables.monster_deaths.get(GlobalVariables.TYPE_OF_MONSTER.SKELETON)) + " killed!!!"
	human_label.text = str(GlobalVariables.monster_deaths.get(GlobalVariables.TYPE_OF_MONSTER.HUMAN)) + " killed..."

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("start_game"):
		GlobalVariables._reset_scores()
		get_tree().paused = false
		get_tree().reload_current_scene()
		queue_free()

	if event.is_action_pressed("leave"):
		get_tree().quit()
