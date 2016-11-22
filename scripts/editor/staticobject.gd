extends Sprite

var objectName = ""
var staticObject = true

func set_object_name(name):
	objectName = name

func get_object_name():
	return objectName

func set_staticObject(b):
	staticObject = b

func get_staticObject():
	return staticObject