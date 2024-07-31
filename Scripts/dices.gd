extends Node

func _ready():
	randomize()

func _dice(faces: int):
	var roll = randi() % (faces) + 1
	return roll


func dice(num: int, faces: int):
	var result: int
	result = 0
	for x in num:
		result += _dice(faces)
	
	return result
