extends Node2D

@onready var spawn = $HeroSpawn
@onready var hero = $Hero
@onready var canExit = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	hero.position = spawn.position;
	Globals.start_quest(PandoraQuests.WELCOME)
	#pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(canExit):
		if Input.is_action_just_pressed("action"):
			print("ACTION")
			canExit = false
			Globals.HeroExitedHouse = true
			get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Hero")):
		body.showActionKey = true
		canExit = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if canExit:
		body.showActionKey = false
		canExit = false
