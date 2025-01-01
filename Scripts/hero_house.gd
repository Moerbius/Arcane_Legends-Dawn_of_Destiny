extends Node2D

@onready var canEnter = false
@onready var heroLastPosition: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(canEnter):
		if Input.is_action_just_pressed("action"):
			print("ACTION")
			canEnter = false
			Globals.HeroLastPosition = heroLastPosition
			get_tree().change_scene_to_file("res://Scenes/Inside/HeroHouseInterior.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Hero")):
		body.showActionKey = true
		canEnter = true
		heroLastPosition = body.position
		


func _on_area_2d_body_exited(body: Node2D) -> void:
	if canEnter:
		if(body.is_in_group("Hero")):
			body.showActionKey = false
			canEnter = false
