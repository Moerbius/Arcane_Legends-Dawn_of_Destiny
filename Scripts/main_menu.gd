extends Control

@onready var labelVersion = $Version

func _ready():
	Globals.set_hud_visible(false)
	MusicController.play_music(MusicController.Musics.MAIN)
	labelVersion.text = "Version " + ProjectSettings.get_setting("application/config/version")


func _on_play_button_pressed():
	Globals.reset_session()
	get_tree().change_scene_to_file("res://Scenes/Inside/HeroHouseInterior.tscn")
	MusicController.play_music(MusicController.Musics.TOWN)

func _on_options_button_pressed():
	print_debug("Options pressed")

func _on_quit_button_pressed():
	get_tree().quit(0)
