extends HBoxContainer

func set_key_value(key, value):
	get_node("RichTextLabel").set_bbcode(key)
	get_node("TextEdit").set_text(str(value))