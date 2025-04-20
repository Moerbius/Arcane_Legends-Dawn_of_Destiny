extends Node

@export var HeroName: String = "Moerbius"
@export var HeroMaxHitPoints: int = 12

@export var HeroHitPoints: int = 6
@export var HeroXP: int

@export var HeroTexture: Texture
@export var HeroLastPosition: Vector2
@export var HeroExitedHouse: bool

@onready var QuestLog = $PanelContainer/QuestLog #$PanelContainer/MarginContainer/QuestLog
@onready var isQuestLogVisible: bool = false

func _ready() -> void:
	await get_tree().process_frame

func _process(_delta) -> void:
	# TODO: if on game, show main menu. If on title screen, quits game
	if Input.is_action_just_pressed("escape"):
		print("ESC key pressed")
		print("Quitting...")
		get_tree().quit(0)
	elif Input.is_action_just_pressed("questlog"):
		isQuestLogVisible = !isQuestLogVisible
	
	if(isQuestLogVisible):
		if(QuestLog != null):
			QuestLog.visible = true
	else:
		if(QuestLog != null):
			QuestLog.visible = false

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
