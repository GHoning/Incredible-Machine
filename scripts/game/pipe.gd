extends Node

var isSimulating = false
var rigidbody

func _ready():
	rigidbody = get_node("RigidBody2D")
	rigidbody.dragable_on()

func start():
	isSimulating = true
	rigidbody.dragable_off()
	
func end():
	isSimulating = false
	rigidbody.dragable_on()