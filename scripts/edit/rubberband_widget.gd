extends Node2D

var mouseOver = false
var mouseDown = false
var turning = false
var mouseOverDelete = false
var square
export(Color) var color

func _ready():
	set_fixed_process(true)
	set_process_input(true)

func setup(ObjectSize):
	get_node("Sprite 2").set_pos(Vector2(-ObjectSize.x, -ObjectSize.y))
	get_node("Sprite 2").set_scale(Vector2(0.5, 0.5))
	square = [Vector2(-ObjectSize.x, -ObjectSize.y),
			Vector2(ObjectSize.x, -ObjectSize.y), 
			Vector2(ObjectSize.x, ObjectSize.y), 
			Vector2(-ObjectSize.x, ObjectSize.y)]
			
func _input(event):
	if event.is_action_pressed("mouse_down"):
		mouseDown = true
	
	if event.is_action_released("mouse_down"):
		mouseDown = false
	
func mouse_over_socket():
	if get_node("RigidBody2D").mouse_over() or get_node("RigidBody2D 2").mouse_over() :
		return true
	else :
		return false

func _fixed_process(delta):
	if mouseDown and mouseOverDelete:
		print(get_parent().get_parent().get_name())
		get_parent().get_parent().queue_free()
	
func _draw():
	draw_line(square[0], square[1], color, 2)
	draw_line(square[1], square[2], color, 2)
	draw_line(square[2], square[3], color, 2)
	draw_line(square[3], square[0], color, 2)

func _on_Delete_mouse_enter():
	mouseOverDelete = true

func _on_Delete_mouse_exit():
	mouseOverDelete = false