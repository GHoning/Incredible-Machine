extends Node

func load_level(storageNode):
	var resources = get_node("/root/resources")
	
	for storageObject in storageNode.get_children() :
		var object_instance
		if storageObject.get_staticObject():
			object_instance = load("res://scenes/editor/static.tscn").instance()
		else:
			object_instance = load("res://scenes/editor/dragable.tscn").instance()

		object_instance.set_object_name(storageObject.get_stored_name())
		object_instance.set_texture(resources.get_image(storageObject.get_stored_name()))
		object_instance.set_transform(storageObject.get_stored_transform())
		add_child(object_instance)