@tool
extends CharacterBody2D

@export var texture: Texture
@export var npcName: String
@export var timeline: String = ""
@export var showExclamationMark: bool = false
@export var showQuestionMark: bool = false
@onready var canInteract: bool

@onready var sprite = $Sprite2D
@onready var exclamationMark = $ExclamationMark
@onready var questionMark = $QuestionMark
@onready var animation = $AnimationPlayer

var hero_in_range: Node2D = null


func _ready():
	sprite.texture = texture

	if showExclamationMark:
		canInteract = true
		exclamationMark.play("default")

	if showQuestionMark:
		canInteract = true
		questionMark.play("default")

	if not showExclamationMark and not showQuestionMark:
		canInteract = false

	animation.play("Idle South")


func _process(_delta):
	if showExclamationMark:
		exclamationMark.show()
		exclamationMark.play("default")
	else:
		exclamationMark.stop()
		exclamationMark.hide()

	if showQuestionMark:
		questionMark.show()
		questionMark.play("default")
	else:
		questionMark.stop()
		questionMark.hide()


func _unhandled_input(event: InputEvent) -> void:
	if Engine.is_editor_hint():
		return
	if hero_in_range == null or timeline.is_empty():
		return
	if not event.is_action_pressed("action"):
		return
	if Dialogic.current_timeline != null:
		return

	get_viewport().set_input_as_handled()
	Dialogic.start(timeline)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Hero"):
		hero_in_range = body
		if not timeline.is_empty():
			body.showActionKey = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == hero_in_range:
		body.showActionKey = false
		hero_in_range = null
