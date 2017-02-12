extends Node2D

var mouseOver = false
var mouseDown = false
var turning = false
var mouseOverDelete = false
var square
export(Color) var color

#get all the objects with a rubberband connector
#then show them 
#and check if over with one of the two connector pieces.
#if that is the case add it to the parent rubberband.


func _ready():
	set_fixed_process(true)
	set_process_input(true)

func setup(ObjectSize):
	get_node("Sprite").set_pos(Vector2(ObjectSize.x, -ObjectSize.y))
	get_node("Sprite").set_scale(Vector2(0.5, 0.5))
	get_node("Sprite 2").set_pos(Vector2(-ObjectSize.x, -ObjectSize.y))
	get_node("Sprite 2").set_scale(Vector2(0.5, 0.5))
	#create four points for the selection window
	square = [Vector2(-ObjectSize.x, -ObjectSize.y),
			Vector2(ObjectSize.x, -ObjectSize.y), 
			Vector2(ObjectSize.x, ObjectSize.y), 
			Vector2(-ObjectSize.x, ObjectSize.y)]
			
func _input(event):
	if event.is_action_pressed("mouse_down"):
		mouseDown = true
	
	if event.is_action_released("mouse_down"):
		mouseDown = false

func _on_mouse_enter():
	mouseOver = true

func _on_mouse_exit():
	mouseOver = false
	
func _fixed_process(delta):
	
	if mouseDown and mouseOverDelete:
		print(get_parent().get_parent().get_name())
		get_parent().get_parent().queue_free()
	
	if mouseOver and mouseDown :
		turning = true
		
	if turning and not mouseDown:
		turning = false
		set_rot(get_parent().get_rot() * -1)
		get_node("Sprite").show()
		get_node("Sprite 2").show()
		
	if turning:
		get_parent().changeCursor(2)
		get_node("Sprite").hide()
		get_node("Sprite 2").hide()
		#if you want it even beter calculate some offset.
		get_parent().look_at(get_global_mouse_pos())
		
	if mouseOver :
		get_parent().changeCursor(2)
	
func _draw():
	draw_line(square[0], square[1], color, 2)
	draw_line(square[1], square[2], color, 2)
	draw_line(square[2], square[3], color, 2)
	draw_line(square[3], square[0], color, 2)

func _on_Delete_mouse_enter():
	mouseOverDelete = true


func _on_Delete_mouse_exit():
	mouseOverDelete = false
