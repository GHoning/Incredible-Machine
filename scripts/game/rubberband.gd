extends Node2D

#what I want here is a two nodes One for each connected item.
var object1
var object2

#add another rigidbody for a selectable thing. If selected draw the cool items.
# I might need custom selection widget

var isSimulating = false
var rigidbody

export(Color) var color

var generator_object

func _ready():
	rigidbody = get_node("RigidBody2D")
	rigidbody.dragable_on()
	
func _has_power():
	if generator_object.has_method("_get_powered") :
		return generator_object._get_powered()
	else:
		return false

func _set_generator(node):
	generator_object = node

func startSimulating():
	isSimulating = true
	rigidbody.dragable_off()
	
func endSimulating():
	isSimulating = false
	rigidbody.dragable_on()