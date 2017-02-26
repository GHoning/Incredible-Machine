extends Node

var isSimulating = false
var rigidbody
var rubberband

export(String) var rubname

export(bool) var staticObject

func _ready():
	rigidbody = get_node("RigidBody2D")
	if !staticObject:
		rigidbody.dragable_on()
		
	if staticObject:
		rubberband = get_parent().get_node(rubname)

func clear_rubberband():
	rubberband = null

func start():
	isSimulating = true
	rigidbody.set_sim(true)
	if !staticObject:
		rigidbody.dragable_off()
		
	if staticObject:
		rubberband = get_parent().get_node(rubname)
	
func end():
	isSimulating = false
	rigidbody.set_sim(false)
	if !staticObject:
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
	
# returns a dictonary of stuff to save for this object
func save():
	var savedict
	if rubberband:
		savedict = {
			filename = get_filename(),
			posX = get_pos().x,
			posY = get_pos().y,
			rot = get_rot(),
			rubberband = rubberband.get_name(),
			objectname = get_name(),
			scalex = get_scale().x,
			scaley = get_scale().y
		}
	else :
		savedict = {
			filename = get_filename(),
			posX = get_pos().x,
			posY = get_pos().y,
			rot = get_rot(),
			rubberband = "null",
			objectname = get_name(),
			scalex = get_scale().x,
			scaley = get_scale().y
		}
	return savedict