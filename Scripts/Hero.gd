#@tool
extends CharacterBody2D

@export var speed = 150  # speed in pixels/sec
@export var showActionKey: bool = false

#@onready var player = $LPCAnimatedSprite2D as LPCAnimatedSprite2D
@onready var actionKeyAnim = $ActionKeyAnimation

@onready var animations = $AnimationPlayer
@onready var Head = $Sprites/Head
@onready var Hair = $Sprites/Hair
@onready var Body = $Sprites/Body
@onready var Torso = $Sprites/Clothing/Torso
@onready var Legs = $Sprites/Clothing/Legs
@onready var Feet = $Sprites/Clothing/Feet
@onready var LeftHand = $Sprites/Weapons/LeftHand
@onready var RightHand = $Sprites/Weapons/RightHand

### HEAD Sprites
@onready var headIdleTexture: Texture = preload("res://Assets/LPC-main/Characters/Head/Head 02 - Masculine/Peach/Idle.png")
@onready var headWalkTexture: Texture = preload("res://Assets/LPC-main/Characters/Head/Head 02 - Masculine/Peach/Walk.png")

### HAIR Sprites
@onready var hairIdleTexture: Texture = preload("res://Assets/LPC-main/Characters/Hair/Short 02 - Parted/Chestnut/Idle.png")
@onready var hairWalkTexture: Texture = preload("res://Assets/LPC-main/Characters/Hair/Short 02 - Parted/Chestnut/Walk.png")

### BODY Sprites
@onready var bodyIdleTexture: Texture = preload("res://Assets/LPC-main/Characters/Body/Body 02 - Masculine, Thin/Peach/Idle.png")
@onready var bodyWalkTexture: Texture = preload("res://Assets/LPC-main/Characters/Body/Body 02 - Masculine, Thin/Peach/Walk.png")

### TORSO Sprites
@onready var torsoIdleTexture: Texture = preload("res://Assets/LPC-main/Characters/Clothing/Masculine, Thin/Torso/Shirt 04 - T-shirt/Blue/Idle.png")
@onready var torsoWalkTexture: Texture = preload("res://Assets/LPC-main/Characters/Clothing/Masculine, Thin/Torso/Shirt 04 - T-shirt/Blue/Walk.png")

### LEGS Sprites
@onready var legsIdleTexture: Texture = preload("res://Assets/LPC-main/Characters/Clothing/Masculine, Thin/Legs/Pants 03 - Pants/Amethyst/Idle.png")
@onready var legsWalkTexture: Texture = preload("res://Assets/LPC-main/Characters/Clothing/Masculine, Thin/Legs/Pants 03 - Pants/Amethyst/Walk.png")

### FEET Sprites
@onready var feetIdleTexture: Texture = preload("res://Assets/LPC-main/Characters/Clothing/Masculine, Thin/Feet/Shoes 02 - Boots/Brown/Idle.png")
@onready var feetWalkTexture: Texture = preload("res://Assets/LPC-main/Characters/Clothing/Masculine, Thin/Feet/Shoes 02 - Boots/Brown/Walk.png")

### LEFT HAND WEAPON Sprites
@onready var leftHandIdleTexture: Texture # = preload("res://Assets/LPC-main/Characters/Props/Shield 01 - Heater Shield/Wood/Oak/Combat 1h - Idle.png")
@onready var leftHandWalkTexture: Texture

### RIGHT HAND WEAPON Sprites
@onready var rightHandIdleTexture: Texture # = preload("res://Assets/LPC-main/weapons-extended/longsword.png")
@onready var rightHandWalkTexture: Texture # = preload("res://Assets/LPC-main/weapons-extended/longsword.png")

@export var hasWeaponLeft: bool = true
@export var hasWeaponRight: bool = true

@onready var weaponLeft = $Sprites/Weapons/LeftHand
@onready var weaponRight = $Sprites/Weapons/RightHand

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
	
	if(hasWeaponLeft):
		weaponLeft.visible = true
	else:
		weaponLeft.visible = false
	
	if(hasWeaponRight):
		weaponRight.visible = true
	else:
		weaponRight.visible = false
	
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
		Head.texture = headIdleTexture
		Hair.texture = hairIdleTexture
		Body.texture = bodyIdleTexture
		Torso.texture = torsoIdleTexture
		Legs.texture = legsIdleTexture
		Feet.texture = feetIdleTexture
		LeftHand.texture = leftHandIdleTexture
		RightHand.texture = rightHandIdleTexture
		
		Globals.HeroHeadTexture = Head.texture
		Globals.HeroHairTexture = Hair.texture
		Globals.HeroBodyTexture = Body.texture
		Globals.HeroTorsoTexture = Torso.texture
		
		Head.hframes = 3
		Head.vframes = 4
		Hair.hframes = 3
		Hair.vframes = 4
		Body.hframes = 3
		Body.vframes = 4
		Torso.hframes = 3
		Torso.vframes = 4
		Legs.hframes = 3
		Legs.vframes = 4
		Feet.hframes = 3
		Feet.vframes = 4
		LeftHand.hframes = 2
		LeftHand.vframes = 4
		RightHand.hframes = 2
		RightHand.vframes = 4
		
	elif(stance[0] == "Walk"):
		Head.texture = headWalkTexture
		Hair.texture = hairWalkTexture
		Body.texture = bodyWalkTexture
		Torso.texture = torsoWalkTexture
		Legs.texture = legsWalkTexture
		Feet.texture = feetWalkTexture
		LeftHand.texture = leftHandWalkTexture
		RightHand.texture = rightHandWalkTexture
		
		Head.hframes = 8
		Head.vframes = 4
		Hair.hframes = 8
		Hair.vframes = 4
		Body.hframes = 8
		Body.vframes = 4
		Torso.hframes = 8
		Torso.vframes = 4
		Legs.hframes = 8
		Legs.vframes = 4
		Feet.hframes = 8
		Feet.vframes = 4
		LeftHand.hframes = 8
		LeftHand.vframes = 4
		RightHand.hframes = 8
		RightHand.vframes = 4
	
	
	
