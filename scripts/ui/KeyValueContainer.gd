extends HBoxContainer

var mouse_over = false

func set_key_value(key, value):
	get_node("RichTextLabel").set_bbcode(key)
	get_node("TextEdit").set_text(str(value))
	
func get_mouse_over():
	return mouse_over

func _on_TextEdit_mouse_enter():
	mouse_over = true

func _on_TextEdit_mouse_exit():
	mouse_over = false
	
#Ok als ik zo door ga komt het goed. Eerst even denken over wat er gebeuren moet.
#Nu moet ik de gegevens hier uithalen en doorgeven aan itemwidget.
#Die moet het op zijn beurt dan weer aan dragable vertellen.