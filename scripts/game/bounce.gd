#extends "../editor/dragable.gd"
extends RigidBody2D

# Offset for the gravity
var v = Vector2(0, -9.8)
var bounciness_factor = 1.2

#if hit bounce the hit object higher.
func _on_RigidBody2D_body_enter(body):
	v += body.get_linear_velocity()
	body.set_linear_velocity(v * bounciness_factor)