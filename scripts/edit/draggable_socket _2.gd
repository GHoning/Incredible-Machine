extends RigidBody2D

var mouseOver = false
var mouseDown = false
var overValidSocket = false
var storeObject
var dragging
var offset
var attached = false

func _ready():
	set_fixed_process(true)
	set_process_input(true)

func mouse_over():
	if mouseOver or dragging:
		return true
	else :
		return false 

func _input(event):
	if event.is_action_pressed("mouse_down"):
		mouseDown = true
	
	if event.is_action_released("mouse_down"):
		mouseDown = false
	
func _fixed_process(delta):
		
	if mouseDown and mouseOver and !dragging and !get_node("/root/player").get_moving():
		dragging = true
		get_node("/root/player").set_moving(true)
		offset = get_global_pos() - get_global_mouse_pos()
		
	if dragging :
		set_global_pos(get_global_mouse_pos() + offset)
		
	if !mouseDown && dragging :
		dragging = false
		get_node("/root/player").set_moving(false)
		
	if overValidSocket && !mouseDown && !attached:
		attached = true
		get_parent().get_parent().get_parent().set_socket_object2(storeObject)
		
	if !overValidSocket:
		attached = false

func _on_mouse_enter():
	mouseOver = true

func _on_mouse_exit():
	mouseOver = false

func _on_body_enter( body ):
	if body.get_name() == "bandselector" :
		print("Over valid socket2")
		storeObject = body
		overValidSocket = true

func _on_body_exit( body ):
	overValidSocket = false
