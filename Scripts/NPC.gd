@tool
extends CharacterBody2D

@export var texture: Texture
@export var npcName: String
@export var showExclamationMark: bool = false
@export var showQuestionMark: bool = false
@onready var canInteract: bool #= true

@onready var sprite = $Sprite2D

@onready var exclamationMark = $ExclamationMark
@onready var questionMark = $QuestionMark

@onready var animation = $AnimationPlayer

func _ready():
	
	sprite.texture = texture
	
	var genderString: String
	#var bodyColorString: String
	var headString: String

	if(showExclamationMark):
		canInteract = true
		exclamationMark.play("default")
	
	if(showQuestionMark):
		canInteract = true
		questionMark.play("default")
		
	if(not showExclamationMark and not showQuestionMark):
		canInteract = false
		
	animation.play("Idle South")


func _process(_delta):
	if(showExclamationMark):
		exclamationMark.show()
		exclamationMark.play("default")
	else:
		exclamationMark.stop()
		exclamationMark.hide()
		
	if(showQuestionMark):
		questionMark.show()
		questionMark.play("default")
	else:
		questionMark.stop()
		questionMark.hide()
