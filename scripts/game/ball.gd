extends Node

var isSimulating = false
var rigidbody
var startTransform

export(bool) var staticObject

func _ready():
	rigidbody = get_node("RigidBody2D")
	
	if !staticObject:
		rigidbody.dragable_on()
	
	
	rigidbody.set_mode(RigidBody2D.MODE_KINEMATIC)

func start():
	isSimulating = true
	
	if !staticObject:
		rigidbody.dragable_off()
	
	rigidbody.set_gravity_scale(1)
	startTransform = rigidbody.get_transform()
	rigidbody.set_mode(RigidBody2D.MODE_RIGID)
	#awaken the object by adding no force :)
	rigidbody.add_force(Vector2(0,0),Vector2(0,0))
	
func end():
	isSimulating = false
	
	if !staticObject:
		rigidbody.dragable_on()
		
	rigidbody.set_gravity_scale(0)
	rigidbody.set_mode(RigidBody2D.MODE_KINEMATIC)
	rigidbody.set_transform(startTransform)
	
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