extends Node2D

var mouseOver = false
var mouseDown = false
var turning = false
var mouseOverDelete = false
var square
var startrot
export(Color) var color

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
		get_node("/root/log").add_to_log(get_parent().get_parent().get_name() + " has been deleted")
		get_parent().get_parent().queue_free()
	
	if mouseOver and mouseDown :
		startrot = get_parent().get_rot()
		get_node("/root/player").set_turning(true)
		turning = true
		
	if turning and not mouseDown:
		get_node("/root/log").add_to_log(get_parent().get_parent().get_name()+" rotated from " + str(startrot) + " to " + str(get_parent().get_rot()))
		turning = false
		get_node("/root/player").set_turning(false)
		get_node("Sprite").show()
		get_node("Sprite 2").show()
		
	if turning:
		get_parent().changeCursor(2)
		get_node("Sprite").hide()
		get_node("Sprite 2").hide()
		get_parent().get_parent().look_at(get_global_mouse_pos())
		
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