extends CharacterBody2D

var mouseIsOnExit: bool = false
var mouseIsOnDragg: bool = false
var draggingDistance
var dir
var dragging
var newPosition = Vector2()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() && mouseIsOnExit:
			self.visible = false
		
	if event is InputEventMouseButton:
		if event.is_pressed() && mouseIsOnDragg:
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			dragging = true
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
		else:
			dragging = false
	elif event is InputEventMouseMotion:
		if dragging:
			newPosition = get_viewport().get_mouse_position() - draggingDistance * dir

func _physics_process(delta: float) -> void:
	if dragging:
		velocity = (newPosition - position) * Vector2(30, 30)
		move_and_slide()


func _on_area_2d_exit_mouse_entered() -> void:
	mouseIsOnExit = true


func _on_area_2d_exit_mouse_exited() -> void:
	mouseIsOnExit = false


func _on_area_2d_dragg_mouse_entered() -> void:
	mouseIsOnDragg = true


func _on_area_2d_dragg_mouse_exited() -> void:
	mouseIsOnDragg = false
