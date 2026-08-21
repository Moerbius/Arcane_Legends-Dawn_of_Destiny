extends Node2D

@onready var canEnter = false
@onready var heroLastPosition: Vector2


func _process(_delta: float) -> void:
	if canEnter and Input.is_action_just_pressed("action"):
		if Dialogic.current_timeline != null:
			return
		canEnter = false
		Globals.save_outdoor_position(heroLastPosition)
		get_tree().change_scene_to_file("res://Scenes/Inside/HeroHouseInterior.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Hero"):
		body.showActionKey = true
		canEnter = true
		heroLastPosition = body.position


func _on_area_2d_body_exited(body: Node2D) -> void:
	if canEnter and body.is_in_group("Hero"):
		body.showActionKey = false
		canEnter = false
