extends Node

var isSimulating = false
var rigidbody
var boosterregion

func _ready():
	rigidbody = get_node("RigidBody2D")
	rigidbody.dragable_on()
	boosterregion = get_node("RigidBody2D 2")
	boosterregion.set_sim(false)

func startSimulating():
	isSimulating = true
	boosterregion.set_sim(true)
	rigidbody.dragable_off()
	
func endSimulating():
	isSimulating = false
	boosterregion.set_sim(false)
	rigidbody.dragable_on()