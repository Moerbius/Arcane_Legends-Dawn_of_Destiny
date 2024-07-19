extends CharacterBody2D

var speed = 150  # speed in pixels/sec
@onready var player = $LPCAnimatedSprite2D as LPCAnimatedSprite2D

func _physics_process(_delta):
	#var lastMovement: String
	var direction = Input.get_vector("left", "right", "up", "down")
	var isMoving: bool = false
	velocity = direction * speed
	
	if(direction.x == 0 && direction.y == 0):
		isMoving = false
	else:
		isMoving = true
	
	if(isMoving && Input.is_action_pressed("up")):
		player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_UP)

	if(Input.is_action_just_released("up") && !isMoving):
		player.play(LPCAnimatedSprite2D.LPCAnimation.IDLE_UP)
	
	if(isMoving && Input.is_action_pressed("down")):
		player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_DOWN)

	if(Input.is_action_just_released("down") && !isMoving):
		player.play(LPCAnimatedSprite2D.LPCAnimation.IDLE_DOWN)
	
	if(isMoving && Input.is_action_pressed("left")):
		player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_LEFT)

	#if(Input.is_action_just_released("left")  and !isMoving):
	#	player.play(LPCAnimatedSprite2D.LPCAnimation.IDLE_LEFT)
	
	if(isMoving && Input.is_action_pressed("right")):
		player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_RIGHT)

	#if(Input.is_action_just_released("right")  and !isMoving):
	#	player.play(LPCAnimatedSprite2D.LPCAnimation.IDLE_RIGHT)
	
	if(isMoving and Input.is_action_pressed("left") and Input.is_action_pressed("up")):
		player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_LEFT)
	
	if(isMoving and Input.is_action_pressed("right") and Input.is_action_pressed("up")):
		player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_RIGHT)
	
	if(isMoving and Input.is_action_pressed("left") and Input.is_action_pressed("down")):
		player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_LEFT)
	
	if(isMoving and Input.is_action_pressed("right") and Input.is_action_pressed("down")):
		player.play(LPCAnimatedSprite2D.LPCAnimation.WALK_RIGHT)
	#if(!isMoving && lastMovement == "up"):
	#	player.play(LPCAnimatedSprite2D.LPCAnimation.IDLE_UP)
	
	move_and_slide()
