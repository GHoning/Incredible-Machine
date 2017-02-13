extends Node2D

var band1 = Vector2(0, 0)
var band2 = Vector2(100, 100)

var offset1 = Vector2(20, 0)
var offset2 = Vector2(-20, 0)

#what I want here is a two nodes One for each connected item.
var socket_object1
var socket_object2

export(String) var name_object1
export(String) var name_object2

export(bool) var staticObject

var isSimulating = false
var rigidbody

export(Color) var color

func _ready():
	rigidbody = get_node("RigidBody2D")
	
	if !staticObject :
		rigidbody.dragable_on()
		
	if staticObject :
		socket_object1 = get_parent().get_node(name_object1)
		socket_object2 = get_parent().get_node(name_object2)
		update()
	
func has_power():
	if socket_object1 :
		if socket_object1.has_method("get_powered") :
			return socket_object1.get_powered()
			
	elif socket_object2 :
		if socket_object2.has_method("get_powered") :
			return socket_object2.get_powered()
			
	else :
		return false

func set_socket_object1(o):
	socket_object1 = o.get_parent()
	if(socket_object1.has_method("connect_rubberband")):
		socket_object1.connect_rubberband(self)
		update()
	
	print("set object1")
	
func set_socket_object2(o):
	socket_object2 = o.get_parent()
	if(socket_object2.has_method("connect_rubberband")):
		socket_object2.connect_rubberband(self)
		update()
	
	print("set object2")


func startSimulating():
	isSimulating = true
	if !staticObject :
		rigidbody.dragable_off()
	
func endSimulating():
	isSimulating = false
	if !staticObject :
		rigidbody.dragable_on()
	
	# returns a string of stuff to save for this object
func save():
	var savedict
	if socket_object1 and socket_object2 :
		savedict = {
			filename = get_filename(),
			posX = get_pos().x,
			posY = get_pos().y,
			rot = get_rot(),
			sobject1 = socket_object1.get_name(),
			sobject2 = socket_object2.get_name(),
			objectname = get_name()
		}
	elif !socket_object1 and socket_object2 :
		savedict = {
			filename = get_filename(),
			posX = get_pos().x,
			posY = get_pos().y,
			rot = get_rot(),
			sobject1 = "null",
			sobject2 = socket_object2.get_name(),
			objectname = get_name()
		}
	elif socket_object1 and !socket_object2 :
		savedict = {
			filename = get_filename(),
			posX = get_pos().x,
			posY = get_pos().y,
			rot = get_rot(),
			sobject1 = socket_object1.get_name(),
			sobject2 = "null",
			objectname = get_name()
		}
	else :
		savedict = {
			filename = get_filename(),
			posX = get_pos().x,
			posY = get_pos().y,
			rot = get_rot(),
			sobject1 = "null",
			sobject2 = "null",
			objectname = get_name()
		}
		
	return savedict
	
func _exit_tree():
	if socket_object1 :
		socket_object1.clear_rubberband()
	
	if socket_object2 :
		socket_object2.clear_rubberband()
	
func _draw():
	if socket_object1 and !socket_object2 :
		draw_line(socket_object1.get_pos() - get_pos() + offset1, band2 + offset1, color, 2)
		draw_line(socket_object1.get_pos() - get_pos() + offset2, band2 + offset2, color, 2)
	elif !socket_object1 and socket_object2 :
		draw_line(band1 + offset1, socket_object2.get_pos() - get_pos() + offset1, color, 2)
		draw_line(band1 + offset2, socket_object2.get_pos() - get_pos() + offset2, color, 2)
	elif socket_object1 and socket_object2 :
		draw_line(socket_object1.get_pos() - get_pos() + offset1, socket_object2.get_pos() - get_pos() + offset1, color, 2)
		draw_line(socket_object1.get_pos() - get_pos() + offset2, socket_object2.get_pos() - get_pos() + offset2, color, 2)
	else:
		draw_line(band1 + offset1, band2 + offset1, color, 2)
		draw_line(band1 + offset2, band2 + offset2, color, 2)