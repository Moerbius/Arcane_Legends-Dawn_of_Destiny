extends RigidBody2D

@onready var animation = $AnimatedSprite2D
@onready var message: Label = $Message

var hero_in_range: Node2D = null

func _ready() -> void:
	animation.play()
	message.hide()

func _unhandled_input(event: InputEvent) -> void:
	if hero_in_range == null:
		return
	if not event.is_action_pressed("action"):
		return
	get_viewport().set_input_as_handled()
	message.visible = not message.visible

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Hero"):
		hero_in_range = body
		body.showActionKey = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == hero_in_range:
		body.showActionKey = false
		hero_in_range = null
		message.hide()
