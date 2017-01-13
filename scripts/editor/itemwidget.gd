extends Container

var mouseover_container = false
var mouseover_delete = false

func _ready():
	var parentspritewidth = get_parent().get_node("Sprite").get_texture().get_size().x
	set_pos(Vector2(parentspritewidth/2, 0))

func _on_Delete_button_pressed():
	var Log = get_node("/root/log")
	Log.add_to_log("Deleted " + get_parent().get_name())
	get_parent().queue_free()

func setup_config_options(config):
	#for each option in config
	#config.keys()
	#config.values()
	
	var i = 0
	while (!i == config.size()):
	#for var i = 0,  i == config.size(), i++ :
		var widget_instance = load("res://scenes/ui/KeyValueContainer.tscn").instance()
		widget_instance.set_key_value(config.keys()[i], config.values()[i])
		get_node("VBoxContainer").add_child(widget_instance)
		print(config.keys()[i], config.values()[i])
		i = i + 1


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
	
	if mouseover_container or mouseover_delete:
		return true 
	else:
		return false