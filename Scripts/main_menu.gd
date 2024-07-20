extends Control

func _ready():
	#await get_tree().process_frame
	MusicController.play_music(MusicController.Musics.MAIN)
	

func _on_play_button_pressed():
	pass

func _on_options_button_pressed():
	pass # Replace with function body.

func _on_quit_button_pressed():
	get_tree().quit(0)





func _on_play_button_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	MusicController.play_music(MusicController.Musics.TOWN)
