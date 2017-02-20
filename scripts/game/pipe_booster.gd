extends Node

var isSimulating = false
var rigidbody
var boosterregion

export(bool) var staticObject

func _ready():
	rigidbody = get_node("RigidBody2D")
	if !staticObject:
		rigidbody.dragable_on()
		
	boosterregion = get_node("RigidBody2D 2")
	boosterregion.set_sim(false)

func start():
	isSimulating = true
	boosterregion.set_sim(true)
	if !staticObject:
		rigidbody.dragable_off()
	
func end():
	isSimulating = false
	boosterregion.set_sim(false)
	if !staticObject:
		rigidbody.dragable_on()
	
	# returns a string of stuff to save for this object
func save():
	var savedict = {
		filename = get_filename(),
		posX = get_pos().x,
		posY = get_pos().y,
		rot = get_rot(),
		scalex = get_scale().x,
		scaley = get_scale().y
	}
	return savedict