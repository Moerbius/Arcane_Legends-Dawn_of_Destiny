extends Control

@onready var labelVersion = $Version
@onready var continue_button: TextureButton = $MarginContainer/VBoxContainer/ContinueButton


func _ready():
	Globals.set_hud_visible(false)
	MusicController.play_music(MusicController.Musics.MAIN)
	labelVersion.text = "Version " + ProjectSettings.get_setting("application/config/version")
	_refresh_continue_button()


func _refresh_continue_button() -> void:
	var can_continue := GameSave.has_save()
	continue_button.disabled = not can_continue
	continue_button.modulate = Color(1, 1, 1, 1) if can_continue else Color(1, 1, 1, 0.45)


func _on_play_button_pressed():
	Globals.reset_session()
	get_tree().change_scene_to_file("res://Scenes/Inside/HeroHouseInterior.tscn")
	MusicController.play_music(MusicController.Musics.TOWN)


func _on_continue_button_pressed():
	if not GameSave.has_save():
		return
	if GameSave.load_and_continue():
		MusicController.play_music(MusicController.Musics.TOWN)


func _on_options_button_pressed():
	$Options.open()


func _on_quit_button_pressed():
	get_tree().quit(0)
