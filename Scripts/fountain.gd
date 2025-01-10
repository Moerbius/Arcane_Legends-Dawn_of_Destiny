extends RigidBody2D

@onready var fountain = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fountain.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
