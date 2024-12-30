extends Node2D

@onready var anim = $AnimationPlayer

@onready var sprite = $Control/Sprite2D
@onready var HeroName = $NameFrame/HeroName

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Idle")
	HeroName.text = Globals.HeroName


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	sprite.texture = Globals.HeroTexture
