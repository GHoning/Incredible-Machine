extends RigidBody2D

var sim = false
export var velocity = Vector2(80,0)

func set_sim(b):
	print("Set sim: ", b)
	sim = b

#if hit bounce the hit object higher.
func _on_RigidBody2D_2_body_enter(body):
	print("whut")
	if sim :
		body.set_linear_velocity(velocity)