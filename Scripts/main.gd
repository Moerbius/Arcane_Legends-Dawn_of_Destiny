extends Node2D

@onready var hero = $YSort/Hero

func _ready():
	if Globals.HeroExitedHouse:
		hero.position = Globals.HeroLastPosition

func _process(_delta):
	pass
	#if(Input.is_action_pressed("escape")):
	#	get_tree().quit(0)
