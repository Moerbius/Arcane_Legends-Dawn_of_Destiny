extends Node2D

@onready var hero = $YSort/Hero
@onready var spawn = $HeroSpawn


func _ready():
	Globals.set_hud_visible(true)
	if Globals.HeroHasLastPosition:
		hero.position = Globals.HeroLastPosition
	elif spawn:
		hero.position = spawn.position
