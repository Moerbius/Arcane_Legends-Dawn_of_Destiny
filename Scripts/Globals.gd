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
		var closed_modal := false
		for modal in get_tree().get_nodes_in_group("modal_ui"):
			if modal.visible:
				if modal.has_method("close"):
					modal.close()
				else:
					modal.hide()
				closed_modal = true
		if closed_modal:
			return
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
	HeroHitPoints = 6
	HeroMaxHitPoints = 12
	HeroXP = 0
	QuestSystem.reset_pool()
	GameSave.is_loading = false
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
		GameSave.save_to_disk()
		set_hud_visible(false)
		get_tree().change_scene_to_file(MAIN_MENU_SCENE)


func is_quest_active(_quest: String) -> bool:
	assert(_quest is String)
	var quest := _quest_from_pandora(_quest)
	return QuestSystem.is_quest_active(quest)


func is_quest_completed(_quest: String) -> bool:
	assert(_quest is String)
	var quest := _quest_from_pandora(_quest)
	return QuestSystem.is_quest_completed(quest)


func start_quest(_quest: String) -> Quest:
	assert(_quest is String)
	var quest := _quest_from_pandora(_quest)
	return QuestSystem.start_quest(quest)


func complete_quest(_quest: String) -> Quest:
	assert(_quest is String)
	var quest := _quest_from_pandora(_quest)
	return QuestSystem.complete_quest(quest)


func _quest_from_pandora(quest_id: String) -> Quest:
	var pandora_quest: PandoraQuest = Pandora.get_entity(quest_id) as PandoraQuest
	assert(pandora_quest != null)
	var quest: Quest = pandora_quest.get_quest()
	assert(quest != null)
	quest.id = int(pandora_quest.get_entity_id())
	return quest
