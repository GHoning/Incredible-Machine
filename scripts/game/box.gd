extends Node2D

var isSimulating = false
var rigidbody

export(bool) var staticObject

func _ready():
	rigidbody = get_node("RigidBody2D")
	if !staticObject:
		rigidbody.dragable_on()

func start():
	isSimulating = true
	if !staticObject:
		rigidbody.dragable_off()
	
func end():
	isSimulating = false
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

func _on_Area2D_body_enter( body ):
	if isSimulating && body.get_parent().get_filename() == "res://scenes/game/ball.tscn" :
		print("ball") 
		#do stuff here to end level
		get_parent().get_parent().win_level()
