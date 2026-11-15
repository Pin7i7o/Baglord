extends Node2D

@onready var score_label: Label = $ScoreLabel
@onready var monsters: Node2D = $Monsters

@onready var timer: Timer = $Timer
@onready var timer_label: Label = $TimerLabel

var score: int = 0

func _ready() -> void:
	score_label.text = ("Score: 0")
	for monster in monsters.get_children():
		monster.update_score.connect(_update_score)

func _process(delta: float) -> void:
	timer_label.text = "TIME: " + str(ceili(timer.time_left))

func _update_score(points: int) -> void:
	if (score + points) < 0:
		score = 0
	else:
		score+= points
	score_label.text = ("Score: " + str(score))

func _on_timer_timeout() -> void:
	print("game over")
