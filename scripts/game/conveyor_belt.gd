extends Node

var isSimulating = false
var rigidbody
var rubberband

func _ready():
	rigidbody = get_node("RigidBody2D")
	rigidbody.dragable_on()
	#get_node("bandselector").hide()

func start():
	isSimulating = true
	rigidbody.dragable_off()
	
func end():
	isSimulating = false
	rigidbody.dragable_on()

func show_connector():
	get_node("bandselector").show()
	
func hide_connector():
	get_node("bandselector").hide()
	
func get_power():
	if rubberband:
		return rubberband.has_power()
	else :
		return false
	
	
func connect_rubberband(o):
	rubberband = o
	print("geplakt loop")
	
	# returns a string of stuff to save for this object
func save():
	var savedict = {
		filename = get_filename(),
		posX = get_pos().x,
		posY = get_pos().y,
		rot = get_rot()
	}
	return savedict