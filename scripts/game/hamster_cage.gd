extends Node

var isSimulating = false
var rigidbody

func _ready():
	rigidbody = get_node("RigidBody2D")
	get_node("bandselector").hide()
	rigidbody.dragable_on()

func start():
	isSimulating = true
	rigidbody.dragable_off()
	
func end():
	isSimulating = false
	rigidbody.dragable_on()
	
func connectRubberBand():
	pass
	
func show_connector():
	get_node("bandselector").show()
	
func hide_connector():
	get_node("bandselector").hide()