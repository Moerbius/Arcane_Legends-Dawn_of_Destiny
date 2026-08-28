extends Node

const SAVE_PATH := "user://save.json"
const SAVE_VERSION := 1

var is_loading := false

var _pending_position := Vector2.ZERO
var _pending_texture_type := 0


func _ready() -> void:
	get_tree().auto_accept_quit = false


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_to_disk()
		get_tree().quit()


func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)


func save_to_disk() -> void:
	var scene := get_tree().current_scene
	if scene == null:
		return
	var scene_path := scene.scene_file_path
	if scene_path.is_empty() or scene_path == Globals.MAIN_MENU_SCENE:
		return

	var hero := get_tree().get_first_node_in_group("Hero")
	var position := Vector2.ZERO
	var texture_type := 0
	if hero:
		position = hero.position
		if "textureType" in hero:
			texture_type = int(hero.textureType)

	_bind_all_pandora_quest_ids()

	var data := {
		"version": SAVE_VERSION,
		"scene": scene_path,
		"position": {"x": position.x, "y": position.y},
		"hero": {
			"name": Globals.HeroName,
			"hp": Globals.HeroHitPoints,
			"max_hp": Globals.HeroMaxHitPoints,
			"xp": Globals.HeroXP,
			"texture_type": texture_type,
		},
		"quests": {
			"pools": _pools_for_json(QuestSystem.pool_state_as_dict()),
			"states": QuestSystem.serialize_quests(),
		},
	}

	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("GameSave: could not write %s" % SAVE_PATH)
		return
	file.store_string(JSON.stringify(data, "\t"))


func load_and_continue() -> bool:
	var data := _read_save()
	if data.is_empty():
		return false

	var scene_path := str(data.get("scene", ""))
	if scene_path.is_empty() or not ResourceLoader.exists(scene_path):
		push_error("GameSave: invalid scene in save: %s" % scene_path)
		return false

	_apply_hero_data(data.get("hero", {}))
	_restore_quests(data.get("quests", {}))

	var pos: Variant = data.get("position", {})
	if pos is Dictionary:
		_pending_position = Vector2(float(pos.get("x", 0.0)), float(pos.get("y", 0.0)))
	else:
		_pending_position = Vector2.ZERO
	_pending_texture_type = 0
	var hero_data: Variant = data.get("hero", {})
	if hero_data is Dictionary:
		_pending_texture_type = int(hero_data.get("texture_type", 0))
	is_loading = true

	get_tree().change_scene_to_file(scene_path)
	return true


func apply_if_loading(hero: Node2D) -> bool:
	if not is_loading:
		return false
	if hero:
		hero.position = _pending_position
		if "textureType" in hero:
			hero.textureType = _pending_texture_type
			if hero.has_method("changeTexture"):
				hero.changeTexture(_pending_texture_type)
	is_loading = false
	return true


func _read_save() -> Dictionary:
	if not has_save():
		return {}
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		return {}
	var parsed: Variant = JSON.parse_string(file.get_as_text())
	if parsed == null or not parsed is Dictionary:
		push_error("GameSave: save file is not valid JSON")
		return {}
	return parsed


func _apply_hero_data(hero_data: Variant) -> void:
	if not hero_data is Dictionary:
		return
	Globals.HeroName = str(hero_data.get("name", Globals.HeroName))
	Globals.HeroHitPoints = int(hero_data.get("hp", Globals.HeroHitPoints))
	Globals.HeroMaxHitPoints = int(hero_data.get("max_hp", Globals.HeroMaxHitPoints))
	Globals.HeroXP = int(hero_data.get("xp", Globals.HeroXP))


func _restore_quests(quests_data: Variant) -> void:
	QuestSystem.reset_pool()
	if not quests_data is Dictionary:
		return
	var quests := _collect_pandora_quests()
	var pools: Variant = quests_data.get("pools", {})
	if pools is Dictionary:
		QuestSystem.restore_pool_state_from_dict(pools, quests.duplicate())
	var states: Variant = quests_data.get("states", {})
	if states is Dictionary:
		QuestSystem.deserialize_quests(_normalize_quest_states(states))
	for quest in QuestSystem.get_active_quests():
		quest.start()


func _collect_pandora_quests() -> Array[Quest]:
	var quests: Array[Quest] = []
	var category := Pandora.get_category(PandoraCategories.QUESTS)
	if category == null:
		return quests
	for entity in Pandora.get_all_entities(category):
		var pandora_quest := entity as PandoraQuest
		if pandora_quest == null:
			continue
		var quest := pandora_quest.get_quest()
		if quest == null:
			continue
		quest.id = int(pandora_quest.get_entity_id())
		quests.append(quest)
	return quests


func _bind_all_pandora_quest_ids() -> void:
	_collect_pandora_quests()


func _pools_for_json(pools: Dictionary) -> Dictionary:
	var out := {}
	for pool_name in pools:
		var ids: Array = []
		for quest_id in pools[pool_name]:
			ids.append(int(quest_id))
		out[pool_name] = ids
	return out


func _normalize_quest_states(states: Dictionary) -> Dictionary:
	var out := {}
	for quest_id in states:
		var data: Variant = states[quest_id]
		if data is Dictionary:
			data = data.duplicate(true)
			if data.has("steps") and data.steps is Dictionary:
				var steps_out := {}
				for step_key in data.steps:
					steps_out[int(step_key)] = data.steps[step_key]
				data.steps = steps_out
		out[str(quest_id)] = data
	return out
