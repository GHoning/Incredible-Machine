extends RigidBody2D

var powered = true
const impulse = Vector2(80,0)

func _integrate_forces(state):
	if(!state.get_contact_count() == 0):
		for body in get_colliding_bodies():
			body.set_linear_velocity(impulse)
	
	#if object.hasMethod("get fucked") do getfucked