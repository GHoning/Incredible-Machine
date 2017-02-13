extends Node

var isSimulating = false
var rigidbody
var rubberband

export(bool) var staticObject
export(String) var rubname

func _ready():
	rigidbody = get_node("RigidBody2D")
	#get_node("bandselector").hide()
	if !staticObject:
		rigidbody.dragable_on()
		
	if staticObject:
		rubberband = get_parent().get_node(rubname)
		
func clear_rubberband():
	rubberband = null

func get_powered():
	return rigidbody._get_powered()

func start():
	isSimulating = true
	rigidbody.set_sim(true)
	if !staticObject:
		rigidbody.dragable_off()
	
func end():
	isSimulating = false
	rigidbody.set_sim(false)
	if !staticObject:
		rigidbody.dragable_on()
	
func connect_rubberband(o):
	rubberband = o
	print("geplakt")
	
func show_connector():
	get_node("bandselector").show()
	
func hide_connector():
	get_node("bandselector").hide()
	
	# returns a string of stuff to save for this object
func save():
	var savedict
	if rubberband:
		savedict = {
			filename = get_filename(),
			posX = get_pos().x,
			posY = get_pos().y,
			rot = get_rot(),
			rubberband = rubberband.get_name(),
			objectname = get_name()
		}
	else :
		savedict = {
			filename = get_filename(),
			posX = get_pos().x,
			posY = get_pos().y,
			rot = get_rot(),
			rubberband = "null",
			objectname = get_name()
		}
	return savedict