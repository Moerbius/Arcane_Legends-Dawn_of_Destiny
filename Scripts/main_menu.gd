extends Control

@onready var labelVersion = $Version

func _ready():
	#await get_tree().process_frame
	MusicController.play_music(MusicController.Musics.MAIN)
	labelVersion.text = "Version " + ProjectSettings.get_setting("application/config/version")
	
func _process(_delta):
	pass
	#print_debug(Dices.dice(2, 10))

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	MusicController.play_music(MusicController.Musics.TOWN)

func _on_options_button_pressed():
	print_debug("Options pressed")

func _on_quit_button_pressed():
	get_tree().quit(0)


