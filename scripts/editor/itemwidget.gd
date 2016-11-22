extends Container

var mouseover_container = false
var mouseover_delete = false
var mouseover_line = false
var mouseover_text = false

func _ready():
	var parentspritewidth = get_parent().get_node("Sprite").get_texture().get_size().x 
	if get_parent().get_object_name() == "conveyor" :
		get_node("LineEdit").queue_free()
		get_node("RichTextLabel").queue_free()
		
	set_pos(Vector2(parentspritewidth/2, 0))

func set_degrees(inputFloat):
	get_node("LineEdit").set_text(str(inputFloat))

func _on_Delete_button_pressed():
	var Log = get_node("/root/log")
	Log.add_to_log("Deleted " + get_parent().get_name())
	get_parent().queue_free()

func _on_LineEdit_text_entered( text ):
	if(text.is_valid_float()):
		#make this part dynamic later
		get_parent().set_rotd(text.to_float())
		set_rotation_deg(-text.to_float())

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

# text
func _on_RichTextLabel_mouse_enter():
	mouseover_text = true

func _on_RichTextLabel_mouse_exit():
	mouseover_text = false

#edit
func _on_LineEdit_mouse_enter():
	mouseover_line = true

func _on_LineEdit_mouse_exit():
	mouseover_line = false
	


#return 
func is_mouse_in_container():
	
	if mouseover_container or mouseover_text or mouseover_line or mouseover_delete:
		return true 
	else:
		return false