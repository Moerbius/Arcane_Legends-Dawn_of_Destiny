extends Node

const SAVE_PATH := "user://settings.cfg"

const RESOLUTIONS: Array[Vector2i] = [
	Vector2i(1152, 648),
	Vector2i(1280, 720),
	Vector2i(1600, 900),
	Vector2i(1920, 1080),
	Vector2i(2560, 1440),
]

var master_volume: float = 0.8
var music_volume: float = 1.0
var sfx_volume: float = 1.0
var window_size: Vector2i = Vector2i(1152, 648)
var fullscreen: bool = false


func _ready() -> void:
	load_from_disk()
	apply_audio()
	call_deferred("apply_video")


func load_from_disk() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(SAVE_PATH) != OK:
		return
	master_volume = clampf(float(cfg.get_value("audio", "master", master_volume)), 0.0, 1.0)
	music_volume = clampf(float(cfg.get_value("audio", "music", music_volume)), 0.0, 1.0)
	sfx_volume = clampf(float(cfg.get_value("audio", "sfx", sfx_volume)), 0.0, 1.0)
	window_size = Vector2i(
		int(cfg.get_value("video", "width", window_size.x)),
		int(cfg.get_value("video", "height", window_size.y))
	)
	fullscreen = bool(cfg.get_value("video", "fullscreen", fullscreen))


func save_to_disk() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("audio", "master", master_volume)
	cfg.set_value("audio", "music", music_volume)
	cfg.set_value("audio", "sfx", sfx_volume)
	cfg.set_value("video", "width", window_size.x)
	cfg.set_value("video", "height", window_size.y)
	cfg.set_value("video", "fullscreen", fullscreen)
	cfg.save(SAVE_PATH)


func apply_audio() -> void:
	_set_bus_volume("Master", master_volume)
	_set_bus_volume("Music", music_volume)
	_set_bus_volume("SFX", sfx_volume)


func can_use_fullscreen() -> bool:
	return not Engine.is_embedded_in_editor()


func apply_video() -> void:
	var win := get_window()
	if win == null:
		return
	if fullscreen and can_use_fullscreen():
		win.mode = Window.MODE_FULLSCREEN
		return
	win.mode = Window.MODE_WINDOWED
	if can_use_fullscreen():
		win.size = window_size
		var screen := DisplayServer.screen_get_usable_rect()
		win.position = screen.position + (screen.size - window_size) / 2


func set_master_volume(value: float) -> void:
	master_volume = clampf(value, 0.0, 1.0)
	_set_bus_volume("Master", master_volume)


func set_music_volume(value: float) -> void:
	music_volume = clampf(value, 0.0, 1.0)
	_set_bus_volume("Music", music_volume)


func set_sfx_volume(value: float) -> void:
	sfx_volume = clampf(value, 0.0, 1.0)
	_set_bus_volume("SFX", sfx_volume)


func set_resolution(size: Vector2i) -> void:
	window_size = size
	if not fullscreen:
		apply_video()


func set_fullscreen(enabled: bool) -> void:
	fullscreen = enabled
	apply_video()


func _set_bus_volume(bus_name: String, linear: float) -> void:
	var idx := AudioServer.get_bus_index(bus_name)
	if idx < 0:
		return
	if linear <= 0.001:
		AudioServer.set_bus_mute(idx, true)
		AudioServer.set_bus_volume_db(idx, -80.0)
	else:
		AudioServer.set_bus_mute(idx, false)
		AudioServer.set_bus_volume_db(idx, linear_to_db(linear))
