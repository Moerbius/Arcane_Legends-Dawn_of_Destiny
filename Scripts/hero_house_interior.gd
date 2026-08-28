extends Node2D

@onready var spawn = $HeroSpawn
@onready var hero = $Hero
@onready var canExit = false


func _ready() -> void:
	Globals.set_hud_visible(true)
	if GameSave.apply_if_loading(hero):
		return
	hero.position = spawn.position
	if not Globals.is_quest_active(PandoraQuests.WELCOME) \
			and not Globals.is_quest_completed(PandoraQuests.WELCOME):
		Globals.start_quest(PandoraQuests.WELCOME)


func _process(_delta: float) -> void:
	if canExit and Input.is_action_just_pressed("action"):
		canExit = false
		get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Hero"):
		body.showActionKey = true
		canExit = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if canExit:
		body.showActionKey = false
		canExit = false
