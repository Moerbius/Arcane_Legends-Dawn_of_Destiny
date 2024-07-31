extends Node2D

@onready var anim = $AnimationPlayer
@onready var Head = $Control/Head
@onready var Hair = $Control/Hair
@onready var Body = $Control/Body
@onready var Clothing = $Control/Clothing
@onready var HeroName = $NameFrame/HeroName

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Idle")
	HeroName.text = Globals.HeroName


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Head.texture = Globals.HeroHeadTexture
	Hair.texture = Globals.HeroHairTexture
	Body.texture = Globals.HeroBodyTexture
	Clothing.texture = Globals.HeroTorsoTexture
