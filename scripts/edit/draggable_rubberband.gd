extends RigidBody2D

var dragging = false
var mouse_over = false
var mouse_down = false
var selected = false
var attachedWidget = false
var widget
var cursor
var cursormode = 0
var offset
var startpos

func _ready():
	cursor = get_parent().get_parent().get_parent().get_parent().get_node("Cursor")

func dragable_on():
	set_process_input(true)
	set_fixed_process(true)
	set_pickable(true)
	
func dragable_off():
	set_process_input(false)
	set_fixed_process(false)
	set_pickable(false)

func _input(event):
	if event.is_action_pressed("mouse_down"):
		mouse_down = true
	
	if event.is_action_released("mouse_down"):
		mouse_down = false
	
func _fixed_process(delta):
	if mouse_down and mouse_over and !get_node("/root/player").get_turning() and !get_node("/root/player").get_moving():
		selected = true
		spawn_widget()
	
	if attachedWidget :
		if mouse_down and !mouse_over and !widget.mouseOver and !widget.turning and !widget.mouseOverDelete and !widget.mouse_over_socket():
			selected = false
			remove_widget()
	else :
		if mouse_down and !mouse_over:
			selected = false
			remove_widget()
			
	if mouse_down and mouse_over and selected  and !dragging:
		dragging = true
		get_node("/root/player").set_moving(true)
		startpos = get_parent().get_global_pos()
		offset = get_parent().get_global_pos() - get_global_mouse_pos()
		
	if selected and mouse_over:
		changeCursor(1)
	else :
		changeCursor(0)
	
	if dragging :
		get_parent().set_global_pos(get_global_mouse_pos() + offset)
		
	if !mouse_down && dragging :
		dragging = false
		get_node("/root/player").set_moving(false)
		get_node("/root/log").add_to_log("Moved: "+get_parent().get_name()+" from " + str(startpos)+ " to " + str(get_parent().get_global_pos()))
		
func changeCursor(i):
	if cursormode !=  i :
		cursormode = i
		if i == 0:
			cursor.set_Normal()
		elif i == 1:
			cursor.set_moveObject()
		elif i == 2:
			cursor.set_turnObject()
	
#Add and remove widget
func spawn_widget():
	if(!attachedWidget):
		attachedWidget = true
		#spawn a special widget for the rubberband.
		var widgetInstance = load("res://scenes/ui/rubberband_widget.tscn").instance()
		widgetInstance.setup(Vector2(100,100))
		widgetInstance.set_pos(Vector2(50,50))
		widgetInstance.set_rot(get_rot() * -1)
		add_child(widgetInstance)
		widget = get_node("rubberband_widget")
	
func remove_widget():
	if(attachedWidget):
		widget.free()
		attachedWidget = false
	
#Events from the sprite to see if there is a mouse over going on.
func _on_mouse_enter():
	mouse_over = true
	
func _on_mouse_exit():
	if not dragging:
		mouse_over = false