#move this to a the gameObject.
extends RigidBody2D

var dragging = false
var mouse_over = false
var mouse_down = false
var selected = false
var attachedWidget = false
var widget
var cursor
var cursormode = 0
var simulating = false

var offset

var startpos

#first click to select the dragable to select it. It draws a selection thing. 
#When the user clicks on the object again they can move it.
#WHen they click a thing on the top they can turn the object.
func _ready():
	#get the cursor form the game.
	#print("Ready")
	cursor = get_parent().get_parent().get_parent().get_parent().get_node("Cursor")

func set_simulating(b) :
	simulating = b

#turning the dragging on and off
func dragable_on():
	set_process_input(true)
	set_fixed_process(true)
	set_pickable(true)
	simulating = false
	

func dragable_off():
	set_process_input(false)
	set_fixed_process(false)
	set_pickable(false)
	simulating = true

#inputs to check if mouse is down and such.
func _input(event):
	if event.is_action_pressed("mouse_down"):
		mouse_down = true
	
	if event.is_action_released("mouse_down"):
		mouse_down = false
	
#this needs to be done better.
func _fixed_process(delta):
	if mouse_down and mouse_over and !get_node("/root/player").get_turning() and !get_node("/root/player").get_moving():
		selected = true
		spawn_widget()
	
	if attachedWidget :
		if mouse_down and !mouse_over and !widget.mouseOverDelete:
			selected = false
			remove_widget()
	else :
		if mouse_down and !mouse_over:
			selected = false
			remove_widget()
			
	if mouse_down and mouse_over and selected  and !dragging:
		dragging = true
		get_node("/root/player").set_moving(true)
		#store start pos here
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
		#add the log here
		get_node("/root/log").add_to_log("Moved: "+get_parent().get_name()+" from " + str(startpos)+ " to " + str(get_parent().get_global_pos()))
		
		
#change cursor
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
		var widgetInstance = load("res://scenes/ui/selected_item_widget_no_turn.tscn").instance()
		widgetInstance.setup(get_node("Sprite").get_texture().get_size())
		widgetInstance.set_rot(get_rot() * -1)
		add_child(widgetInstance)
		widget = get_node("selected_item_widget_no_turn")
	
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
		
# Offset for the gravity
var v = Vector2(0, -9.8)
export var bounciness_factor = 1.2

#if hit bounce the hit object higher.
func _on_RigidBody2D_body_enter(body):
	if simulating :
		v += body.get_linear_velocity()
		v.y = -v.y
		body.set_linear_velocity(v * bounciness_factor)
		v = Vector2(0, -9.8)