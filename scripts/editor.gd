extends Node

func load_level(level):
	
	var resources = get_node("/root/resources")
	
	for object in level:
		var object_instance
		#check if it is a level static item.
		if(object.staticObject):
			#if it is spawn the static editor object
			object_instance = load("res://scenes/editor/static.tscn").instance()
		else:
			#else choose the editable one.
			object_instance = load("res://scenes/editor/dragable.tscn").instance()
			
		object_instance.set_object_name(object.name)
		object_instance.set_texture(resources.get_image(object.name))
		object_instance.set_transform(object.transform)
		add_child(object_instance)