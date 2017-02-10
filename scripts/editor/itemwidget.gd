extends Container

var configuration

func _ready():
	#var parentspritewidth = get_parent().get_node("Sprite").get_texture().get_size().x
	#set_pos(Vector2(parentspritewidth/2, 0))
	print(has_focus())
	
func _draw():
	pass
	#draw_line(Vector2(100,100), Vector2(100, 200), Color(255,0,0), 2)
	#draw_circle(get_pos(), 50, Color(255,0,0))

func _on_Delete_button_pressed():
	var Log = get_node("/root/log")
	Log.add_to_log("Deleted " + get_parent().get_name())
	get_parent().queue_free()

func setup_config_options(config):
	configuration = config
	for i in range (0, config.size(), 1) :
		var widget_instance = load("res://scenes/ui/KeyValueContainer.tscn").instance()
		widget_instance.set_key_value(config.keys()[i], config.values()[i])
		get_node("VBoxContainer").add_child(widget_instance)
		print(config.keys()[i], config.values()[i])

func return_dict():
	var KeyValueArray = get_node("VBoxContainer").get_children()
	
	for i in range(0 ,KeyValueArray.size(), 1):
		print(" in the storage ",configuration.values()[i], KeyValueArray[i].get_node("TextEdit").get_text())
		configuration.values()[i] = KeyValueArray[i].get_node("TextEdit").get_text()
		
	print(configuration.values()[0])
	return configuration
	
func checkOverlapInVbox():
	for i in get_node("VBoxContainer").get_children():
		if i.get_mouse_over() :
			return true

	return false

var mouseover_container = false
var mouseover_delete = false
var mouseover_VBOX = false


#container
func _on_Container_mouse_enter():
	mouseover_container = true
	
func _on_Container_mouse_exit():
	mouseover_container = false

#delete button
func _on_Delete_button_mouse_enter():
	mouseover_delete = true

func _on_Delete_button_mouse_exit():
	mouseover_delete = false
 
func is_mouse_in_container():
	
	if mouseover_container or mouseover_delete or mouseover_VBOX or checkOverlapInVbox():
		return true 
	else:
		return false

func _on_VBoxContainer_mouse_enter():
	mouseover_VBOX = true

func _on_VBoxContainer_mouse_exit():
	mouseover_VBOX = false
