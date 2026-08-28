extends Control

const WINDOW_TILES := Vector2i(26, 21)

@onready var frame: TileMapLayer = %Frame
@onready var master_slider: HSlider = %MasterSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SfxSlider
@onready var master_value: Label = %MasterValue
@onready var music_value: Label = %MusicValue
@onready var sfx_value: Label = %SfxValue
@onready var resolution_option: OptionButton = %ResolutionOption
@onready var fullscreen_check: CheckButton = %FullscreenCheck


func _ready() -> void:
	add_to_group("modal_ui")
	#_draw_window_frame()
	_populate_resolutions()
	_load_ui_from_settings()
	visible = false
	mouse_filter = Control.MOUSE_FILTER_IGNORE


func open() -> void:
	_load_ui_from_settings()
	visible = true
	mouse_filter = Control.MOUSE_FILTER_STOP


func close() -> void:
	GameSettings.save_to_disk()
	visible = false
	mouse_filter = Control.MOUSE_FILTER_IGNORE


#func _draw_window_frame() -> void:
#	var fill := Vector2i(3, 7)
#	var top := Vector2i(2, 6)
#	var bottom := Vector2i(2, 16)
#	var left := Vector2i(0, 8)
#	var right := Vector2i(6, 9)
#	var tl := Vector2i(0, 6)
#	var tr := Vector2i(6, 6)
#	var bl := Vector2i(0, 16)
#	var br := Vector2i(6, 16)
#
#	for x in WINDOW_TILES.x:
#		for y in WINDOW_TILES.y:
#			var atlas := fill
#			var on_left := x == 0
#			var on_right := x == WINDOW_TILES.x - 1
#			var on_top := y == 0
#			var on_bottom := y == WINDOW_TILES.y - 1
#			if on_top and on_left:
#				atlas = tl
#			elif on_top and on_right:
#				atlas = tr
#			elif on_bottom and on_left:
#				atlas = bl
#			elif on_bottom and on_right:
#				atlas = br
#			elif on_top:
#				atlas = top
#			elif on_bottom:
#				atlas = bottom
#			elif on_left:
#				atlas = left
#			elif on_right:
#				atlas = right
#			frame.set_cell(Vector2i(x, y), 0, atlas)


func _populate_resolutions() -> void:
	resolution_option.clear()
	for size in GameSettings.RESOLUTIONS:
		resolution_option.add_item("%s x %s" % [size.x, size.y])


func _load_ui_from_settings() -> void:
	master_slider.set_value_no_signal(GameSettings.master_volume * 100.0)
	music_slider.set_value_no_signal(GameSettings.music_volume * 100.0)
	sfx_slider.set_value_no_signal(GameSettings.sfx_volume * 100.0)
	_update_volume_labels()

	var index := GameSettings.RESOLUTIONS.find(GameSettings.window_size)
	if index < 0:
		index = 0
		GameSettings.window_size = GameSettings.RESOLUTIONS[0]
	resolution_option.select(index)
	var embedded := not GameSettings.can_use_fullscreen()
	fullscreen_check.disabled = embedded
	fullscreen_check.tooltip_text = "Fullscreen is unavailable in the editor Game view. Run with the game window detached, or from an exported build." if embedded else ""
	fullscreen_check.set_pressed_no_signal(false if embedded else GameSettings.fullscreen)
	resolution_option.disabled = GameSettings.fullscreen and not embedded


func _update_volume_labels() -> void:
	master_value.text = str(int(master_slider.value))
	music_value.text = str(int(music_slider.value))
	sfx_value.text = str(int(sfx_slider.value))


func _on_master_slider_value_changed(value: float) -> void:
	GameSettings.set_master_volume(value / 100.0)
	_update_volume_labels()


func _on_music_slider_value_changed(value: float) -> void:
	GameSettings.set_music_volume(value / 100.0)
	_update_volume_labels()


func _on_sfx_slider_value_changed(value: float) -> void:
	GameSettings.set_sfx_volume(value / 100.0)
	_update_volume_labels()


func _on_resolution_option_item_selected(index: int) -> void:
	if index < 0 or index >= GameSettings.RESOLUTIONS.size():
		return
	GameSettings.set_resolution(GameSettings.RESOLUTIONS[index])


func _on_fullscreen_check_toggled(toggled_on: bool) -> void:
	if not GameSettings.can_use_fullscreen():
		fullscreen_check.set_pressed_no_signal(false)
		return
	GameSettings.set_fullscreen(toggled_on)
	resolution_option.disabled = toggled_on


func _on_back_button_pressed() -> void:
	close()
