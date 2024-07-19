extends Control

func _ready():
	MusicController.play_music(MusicController.Musics.MAIN)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	MusicController.play_music(MusicController.Musics.TOWN)
	
	
func _on_option_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit(0)
