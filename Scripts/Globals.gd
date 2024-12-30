extends Node

@export var HeroName: String = "Moerbius"
@export var HeroMaxHitPoints: int = 12

@export var HeroHitPoints: int = 6
@export var HeroXP: int

@export var HeroTexture: Texture

func _process(_delta) -> void:
	# TODO: if on game, show main menu. If on title screen, quits game
	if Input.is_action_just_pressed("escape"):
		print("ESC key pressed")
		print("Quitting...")
		get_tree().quit(0)
