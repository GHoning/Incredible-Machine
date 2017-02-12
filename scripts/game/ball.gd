extends Node

var isSimulating = false
var rigidbody
var startTransform

func _ready():
	rigidbody = get_node("RigidBody2D")
	rigidbody.dragable_on()
	rigidbody.set_mode(RigidBody2D.MODE_KINEMATIC)

func start():
	isSimulating = true
	rigidbody.dragable_off()
	rigidbody.set_gravity_scale(1)
	startTransform = rigidbody.get_transform()
	rigidbody.set_mode(RigidBody2D.MODE_RIGID)
	#awaken the object by adding no force :)
	rigidbody.add_force(Vector2(0,0),Vector2(0,0))
	
func end():
	isSimulating = false
	rigidbody.dragable_on()
	rigidbody.set_gravity_scale(0)
	rigidbody.set_mode(RigidBody2D.MODE_KINEMATIC)
	rigidbody.set_transform(startTransform)
	