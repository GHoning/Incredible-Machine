extends Node2D

var isSimulating = false
var rigidbody

export(bool) var staticObject

func _ready():
	rigidbody = get_node("RigidBody2D")
	if !staticObject:
		rigidbody.dragable_on()

func start():
	isSimulating = true
	if !staticObject:
		rigidbody.dragable_off()
	
func end():
	isSimulating = false
	if !staticObject:
		rigidbody.dragable_on()
	
	# returns a string of stuff to save for this object
func save():
	var savedict = {
		filename = get_filename(),
		posX = get_pos().x,
		posY = get_pos().y,
		rot = get_rot()
	}
	return savedict