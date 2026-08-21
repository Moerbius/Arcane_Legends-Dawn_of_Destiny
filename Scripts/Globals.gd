extends Node

const MAIN_MENU_SCENE := "res://Scenes/main_menu.tscn"

@export var HeroName: String = "Moerbius"
@export var HeroMaxHitPoints: int = 12
@export var HeroHitPoints: int = 6
@export var HeroXP: int
@export var HeroTexture: Texture
@export var HeroLastPosition: Vector2
@export var HeroHasLastPosition: bool = false

@onready var hud: CanvasLayer = $PanelContainer
@onready var QuestLog = $PanelContainer/QuestLog


func _ready() -> void:
	if QuestLog:
		QuestLog.visible = false
	set_hud_visible(false)


func _process(_delta) -> void:
	if Input.is_action_just_pressed("escape"):
		_handle_escape()
	elif Input.is_action_just_pressed("questlog"):
		if hud and hud.visible and QuestLog:
			QuestLog.visible = not QuestLog.visible


func set_hud_visible(is_visible: bool) -> void:
	if hud:
		hud.visible = is_visible
	if not is_visible and QuestLog:
		QuestLog.visible = false


func reset_session() -> void:
	HeroHasLastPosition = false
	HeroLastPosition = Vector2.ZERO
	set_hud_visible(false)


func save_outdoor_position(pos: Vector2) -> void:
	HeroLastPosition = pos
	HeroHasLastPosition = true


func _handle_escape() -> void:
	var current_scene := get_tree().current_scene
	if current_scene == null:
		return
	if current_scene.scene_file_path == MAIN_MENU_SCENE:
		get_tree().quit(0)
	else:
		set_hud_visible(false)
		get_tree().change_scene_to_file(MAIN_MENU_SCENE)


func is_quest_active(_quest: String) -> bool:
	assert(_quest is String)
	var pandora_quest: PandoraQuest = Pandora.get_entity(_quest) as PandoraQuest
	assert(pandora_quest != null)
	return QuestSystem.is_quest_active(pandora_quest.get_quest())


func is_quest_completed(_quest: String) -> bool:
	assert(_quest is String)
	var pandora_quest: PandoraQuest = Pandora.get_entity(_quest) as PandoraQuest
	assert(pandora_quest != null)
	return QuestSystem.is_quest_completed(pandora_quest.get_quest())


func start_quest(_quest: String) -> Quest:
	assert(_quest is String)
	var pandora_quest: PandoraQuest = Pandora.get_entity(_quest) as PandoraQuest
	assert(pandora_quest != null)
	return QuestSystem.start_quest(pandora_quest.get_quest())


func complete_quest(_quest: String) -> Quest:
	assert(_quest is String)
	var pandora_quest: PandoraQuest = Pandora.get_entity(_quest) as PandoraQuest
	assert(pandora_quest != null)
	return QuestSystem.complete_quest(pandora_quest.get_quest())
