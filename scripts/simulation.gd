extends Node

#get te level that needs to be loaded
func load_level(level):
	var resources = get_node("/root/resources")
	
	for object in level:
		var objectInstance = resources.get_item_instance(object.name)
		objectInstance.set_transform(object.transform)
		add_child(objectInstance)
		
	#from here add the test items
	var hamster = load("res://scenes/game/hamstercage.tscn").instance()
	hamster.set_pos(Vector2(450, 700))
	add_child(hamster)
	
	var rubber = load("res://scenes/game/rubberband.tscn").instance()
	rubber.set_pos(Vector2(0, 0))
	rubber.get_node("Node")._set_generator(hamster)
	add_child(rubber)
	
	var conveyor = load("res://scenes/game/conveyor.tscn").instance()
	conveyor.set_pos(Vector2(550,350))
	conveyor._set_rubberband(rubber)
	add_child(conveyor)
	
	var testball = load("res://scenes/game/ball.scn").instance()
	testball.set_pos(Vector2(450, 600))
	add_child(testball)