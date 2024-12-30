extends Node2D

@onready var spawn = $HeroSpawn
@onready var hero = $Hero

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hero.position = spawn.position;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
