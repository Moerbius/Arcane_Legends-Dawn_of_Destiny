extends CharacterBody2D

@export var showExclamationMark: bool = false
@export var showQuestionMark: bool = false
@export var canInteract: bool = true

@onready var exclamationMark = $ExclamationMark
@onready var questionMark = $QuestionMark

func _ready():
	if(showExclamationMark):
		exclamationMark.play("default")
	
	if(showQuestionMark):
		questionMark.play("default")


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


