extends Node

var generator_object

func _ready():
	pass
	
func _has_power():
	if generator_object.has_method("_get_powered") :
		return generator_object._get_powered()
	else:
		return false

func _set_generator(node):
	generator_object = node