extends CharacterBody2D

@export var speed = 150  # speed in pixels/sec
@onready var player = $LPCAnimatedSprite2D as LPCAnimatedSprite2D

var lastAnimation: String
var currentAnimation: String

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
	

	
func playAnimation(name: String):
	lastAnimation = currentAnimation
	
	if(name == "WALK0"):
		player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_RIGHT)
		currentAnimation = "WALK_RIGHT"
	elif(name == "WALK1"):
		player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_RIGHT)
		currentAnimation = "WALK_RIGHT"
	elif(name == "WALK2"):
		player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_DOWN)
		currentAnimation = "WALK_DOWN"
	elif(name == "WALK3"):
		player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_LEFT)
		currentAnimation = "WALK_LEFT"
	elif(name == "WALK4"):
		player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_LEFT)
		currentAnimation = "WALK_LEFT"
	elif(name == "WALK5"):
		player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_LEFT)
		currentAnimation = "WALK_LEFT"
	elif(name == "WALK6"):
		player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_UP)
		currentAnimation = "WALK_UP"
	elif(name == "WALK7"):
		player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_RIGHT)
		currentAnimation = "WALK_RIGHT"
	elif(name == "IDLE"):
		if(lastAnimation == "WALK_RIGHT"):
			player.play(LPCAnimatedSprite2D.LPCAnimation.IDLE_RIGHT)
		elif(lastAnimation == "WALK_DOWN"):
			player.play(LPCAnimatedSprite2D.LPCAnimation.IDLE_DOWN)
		elif(lastAnimation == "WALK_LEFT"):
			player.play(LPCAnimatedSprite2D.LPCAnimation.IDLE_LEFT)
		elif(lastAnimation == "WALK_UP"):
			player.play(LPCAnimatedSprite2D.LPCAnimation.IDLE_UP)
		
		
