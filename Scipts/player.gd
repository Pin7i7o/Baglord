extends CharacterBody2D

@onready var rc_down: RayCast2D = $Down
@onready var rc_up: RayCast2D = $Up
@onready var rc_right: RayCast2D = $Right
@onready var rc_left: RayCast2D = $Left
@onready var sprite_2d: Sprite2D = $Sprite2D

var sprite_node_pos_tween: Tween


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up") and rc_up.is_colliding():
		global_position = rc_up.get_collider().position
	if Input.is_action_just_pressed("ui_down") and rc_down.is_colliding():
		global_position = rc_down.get_collider().position
	if Input.is_action_just_pressed("ui_right") and rc_right.is_colliding():
		global_position = rc_right.get_collider().position
	if Input.is_action_just_pressed("ui_left") and rc_left.is_colliding():
		global_position = rc_left.get_collider().position

	
