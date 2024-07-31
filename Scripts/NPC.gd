@tool
extends CharacterBody2D

@export_enum("Male", "Female", "Child") var gender
@export_enum("Bronze", "Brown", "Coffee", "Honey", "Ivory", "Peach", "Porcelain", "Tan", "Tawny") var BodyColor: String
@export_enum("Medium 01 - Page", "Medium 02 - Curly", "Medium 03 - Idol", "Medium 04 - Bangs & Bun", "Medium 05 - Cornrows", "Medium 06 - Dreadlocks", "Medium 07 - Bob Side Part", "Medium 08 - Bob Bangs", "Medium 09 - Twists", "Medium 10 - Twists Fade", "Short 01 - Buzzcut", "Short 02 - Parted", "Short 03 - Curly", "Short 04 - Cowlick", "Short 05 - Natural", "Short 06 - Balding", "Short 07 - Flat Top", "Short 08 - Flat Top Fade") var HairType: String
@export_enum("Ash Brown", "Black", "Blonde", "Blue", "Brown", "Charcoal", "Chestnut", "Gray", "Green", "Orange", "Pink", "Platinum", "Purple", "Raven", "Red", "Ruby", "Silver", "Teal", "Violet", "White") var HairColor: String

@export var showExclamationMark: bool = false
@export var showQuestionMark: bool = false
@onready var canInteract: bool #= true

@onready var Body = $Sprites/Body
@onready var Head = $Sprites/Head
@onready var Hair = $Sprites/Hair


@onready var exclamationMark = $ExclamationMark
@onready var questionMark = $QuestionMark

@onready var animation = $AnimationPlayer

func _ready():
	
	var genderString: String
	#var bodyColorString: String
	var headString: String

	if(gender == 0):	# MALE
		genderString = "Body 02 - Masculine, Thin"
		headString = "Head 02 - Masculine"
	elif(gender == 1):	# FEMALE
		genderString = "Body 01 - Feminine, Thin"
		headString = "Head 01 - Feminine"


	
	
	Body.texture = load("res://Assets/LPC-main/Characters/Body/" + genderString + "/" + BodyColor + "/Idle.png")
	Head.texture = load("res://Assets/LPC-main/Characters/Head/" + headString + "/" + BodyColor + "/Idle.png")
	Hair.texture = load("res://Assets/LPC-main/Characters/Hair/" + HairType + "/" + HairColor + "/Idle.png")
	
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

