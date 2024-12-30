#@tool
extends CharacterBody2D

@export var speed = 150  # speed in pixels/sec
@export var showActionKey: bool = false
@export_enum("Simple", "SimpleSword", "Wizard") var textureType

@onready var actionKeyAnim = $ActionKeyAnimation

@onready var animations = $AnimationPlayer

@onready var sprite = $Sprite2D

@onready var simpleTexture: Texture = preload("res://Assets/hero/hero.png")
@onready var simpleSwordTexture: Texture = preload("res://Assets/hero/hero_dagger.png")
@onready var wizardTexture: Texture = preload("res://Assets/hero/hero_wizard.png")

var lastAnimation: String = "WALK_DOWN"
var currentAnimation: String = "WALK_DOWN"

func _ready():
	pass


func _physics_process(_delta):
	
	var direction = Input.get_vector("left", "right", "up", "down")
	var isMoving: bool = false
	velocity = direction * speed
	velocity = velocity.normalized() * speed
	
	var angle = direction.angle() / (PI/4)
	angle = wrapi(int(angle), 0, 8)
	
	if(direction.x == 0 && direction.y == 0):
		isMoving = false
	else:
		isMoving = true
	
	move_and_slide()
	
	if(isMoving):
		playAnimation("WALK" + str(angle))
	else:
		playAnimation("IDLE")
	
	if(showActionKey):
		actionKeyAnim.show()
		actionKeyAnim.play("default")
	else:
		actionKeyAnim.hide()
		actionKeyAnim.stop()
	
	if(Input.is_action_just_pressed("action")):
		if(showActionKey):
			print_debug("Action pressed OK")

func playAnimation(animName: String):
	lastAnimation = currentAnimation
	
	if(animName == "WALK0"):
		#player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_RIGHT)
		setupSprites("Walk East")
		animations.play("Walk East")
		currentAnimation = "WALK_RIGHT"
	elif(animName == "WALK1"):
		#player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_RIGHT)
		setupSprites("Walk East")
		animations.play("Walk East")
		currentAnimation = "WALK_RIGHT"
	elif(animName == "WALK2"):
		#player.plway(LPCAnimatedSprite2D.LPCAnimation.WALK_DOWN)
		setupSprites("Walk South")
		animations.play("Walk South")
		currentAnimation = "WALK_DOWN"
	elif(animName == "WALK3"):
		#player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_LEFT)
		setupSprites("Walk West")
		animations.play("Walk West")
		currentAnimation = "WALK_LEFT"
	elif(animName == "WALK4"):
		#player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_LEFT)
		setupSprites("Walk West")
		animations.play("Walk West")
		currentAnimation = "WALK_LEFT"
	elif(animName == "WALK5"):
		#player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_LEFT)
		setupSprites("Walk West")
		animations.play("Walk West")
		currentAnimation = "WALK_LEFT"
	elif(animName == "WALK6"):
		#player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_UP)
		setupSprites("Walk North")
		animations.play("Walk North")
		currentAnimation = "WALK_UP"
	elif(animName == "WALK7"):
		#player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_RIGHT)
		setupSprites("Walk East")
		animations.play("Walk East")
		currentAnimation = "WALK_RIGHT"
	elif(animName == "IDLE"):
		if(lastAnimation == "WALK_RIGHT"):
			setupSprites("Idle East")
			animations.play("Idle East")
			#player.play(LPCAnimatedSprite2D.LPCAnimation.IDLE_RIGHT)
		elif(lastAnimation == "WALK_DOWN"):
			setupSprites("Idle South")
			animations.play("Idle South")
		elif(lastAnimation == "WALK_LEFT"):
			setupSprites("Idle West")
			animations.play("Idle West")
			#player.play(LPCAnimatedSprite2D.LPCAnimation.IDLE_LEFT)
		elif(lastAnimation == "WALK_UP"):
			setupSprites("Idle North")
			animations.play("Idle North")
			#player.play(LPCAnimatedSprite2D.LPCAnimation.IDLE_UP)
		
		


func _on_np_cdetector_body_entered(body):
	if(body.is_in_group("NPC")):
		if(body.canInteract):
			showActionKey = true


func _on_np_cdetector_body_exited(body):
	if(body.is_in_group("NPC")):
		showActionKey = false

func setupSprites(animName: String):
	var stance = animName.split(" ")
	
	if(stance[0] == "Idle"):
		changeTexture(textureType)
		
	elif(stance[0] == "Walk"):
		changeTexture(textureType)
		

func changeTexture(id: int):
	if(id == 0): # Simple
		sprite.texture = simpleTexture
	elif(id == 1): # SimpleSword
		sprite.texture = simpleSwordTexture
	elif(id == 2): # Wizard
		sprite.texture = wizardTexture
	
	Globals.HeroTexture = sprite.texture
