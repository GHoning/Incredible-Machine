extends RigidBody2D

const velocity = Vector2(80,0)

var rubberband

func _set_rubberband(node):
	rubberband = node

func _integrate_forces(state):
	if rubberband :
		if rubberband.get_node("Node").has_method("_has_power"):
			if(!state.get_contact_count() == 0 && rubberband.get_node("Node")._has_power()):
				for body in get_colliding_bodies():
					body.set_linear_velocity(velocity)