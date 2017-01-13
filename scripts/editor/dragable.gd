extends RigidBody2D

const SPEED = 2000
const MAX_MOUSE_DISTANCE = 5.0

var is_dragging = false
var mouse_over = false
var mouse_down = false
var mouse_pos = Vector2()
var mouse_dis
var rigidbody_vector = 0

var offset


#Config 
var config

func get_config():
	return config
	
func set_config(configuration):
	config = configuration



func _ready():
	set_process_input(true)
	set_fixed_process(true)

func _input(event):
	if event.is_action_pressed("mouse_down"):
		mouse_down = true
		
	if event.is_action_released("mouse_down"):
		mouse_down = false
		is_dragging = false

func _fixed_process(delta):
	
	if mouse_down and mouse_over:
		spawn_hud_widget()
		if !is_dragging:
			offset = get_global_pos() - get_global_mouse_pos()
			
		mouse_pos = get_global_mouse_pos() + offset
		
		mouse_dis = get_global_pos().distance_to(mouse_pos)
		
		is_dragging = true
		
		if (mouse_dis <= MAX_MOUSE_DISTANCE):
			#destination reached.
			rigidbody_vector = 0
			set_linear_velocity(Vector2())
		else:
			#move the object
			rigidbody_vector = (mouse_pos - get_global_pos()).normalized()
			set_linear_velocity(rigidbody_vector * SPEED * mouse_dis * delta)
			
	if not mouse_down or not mouse_over:
		#basic thing if nothing is happening.
		is_dragging = false
		set_linear_velocity(Vector2())
		offset = Vector2()
		
	if attachedWidget :
		if get_node("Container").is_mouse_in_container():
			mouse_over = false
		
		#mouse not over the item or the widget 
		if not mouse_over and not get_node("Container").is_mouse_in_container() :
			#remove the widget
			if mouse_down :
				remove_hud_widget()

func _on_movableItem_mouse_exit():
	if not is_dragging:
		mouse_over = false

func _on_movableItem_mouse_enter():
	mouse_over = true

#object interface
var objectName = ""

func get_object_name():
	return objectName
	
func set_object_name(name):
	objectName = name




var staticObject = false

func set_staticObject(b):
	staticObject = b

func get_staticObject():
	return staticObject
	
func set_texture(image):
	get_node("Sprite").set_texture(image)
	
#Here check if clicked on and then spawn a hud container thingy with options.
var attachedWidget = false

func spawn_hud_widget():
	if(!attachedWidget):
		attachedWidget = true
		var ItemWidgetInstance = load("res://scenes/editor/itemwidget.tscn").instance()
		ItemWidgetInstance.setup_config_options(get_node("/root/resources").get_config(get_object_name()))
		add_child(ItemWidgetInstance)
		
func remove_hud_widget():
	if(attachedWidget):
		get_node("Container").free()
		attachedWidget = false