extends CharacterBody2D

@export_enum("Male", "Female", "Child") var gender
@export_enum("Bronze", "Brown", "Coffee", "Honey", "Ivory", "Peach", "Porcelain", "Tan", "Tawny") var BodyColor
@export_enum("Hair1", "Hair2") var HairType
@export_enum("Blonde", "Brown") var HairColor


@export var showExclamationMark: bool = false
@export var showQuestionMark: bool = false
@export var canInteract: bool = true

@onready var exclamationMark = $ExclamationMark
@onready var questionMark = $QuestionMark

@onready var animation = $AnimationPlayer

func _ready():
	if(showExclamationMark):
		exclamationMark.play("default")
	
	if(showQuestionMark):
		questionMark.play("default")
		
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

