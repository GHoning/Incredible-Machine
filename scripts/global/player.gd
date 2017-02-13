extends Node
 
var isTurning = false
var isMoving = false

func set_turning(b):
	isTurning = b
	
func get_turning():
	return isTurning
	
func set_moving(b):
	isMoving = b
	
func get_moving():
	return isMoving