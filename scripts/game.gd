extends Node

var simulating = false
var replay = false
var currentLevel = []
var world
var playtime

func store_playtime():
	var playedfile = File.new()
	var playedpath = "res://saves/playtimes.stayout"
	#load it here if needed.
	var storage = {
		"played" : playtime
	}
	playedfile.open(playedpath, File.WRITE)
	playedfile.store_string(storage.to_json())
	playedfile.close()
	
func restart_level():
	#check if how many times we played
	var playfile = File.new()
	var playpath = "res://saves/playtimes.stayout"
	#load it here if needed.
	var loadingObject = {}
	playfile.open(playpath, File.READ)
	loadingObject.parse_json(playfile.get_line())
	playfile.close()
	playtime = loadingObject.played
	
	#ugly spawning for now.
	var TestEditor = get_node("Editor")
	
	for o in TestEditor.get_children():
		o.free()
	
	#make some sort of level file. Because this is ugly :)
	var testInstance = load("res://scenes/editor/static.tscn").instance()
	var resources = get_node("/root/resources")
	testInstance.set_pos(Vector2(200, 200))
	testInstance.set_object_name("ball")
	testInstance.set_texture(resources.get_image("ball"))
	testInstance.set_z(-20)
	TestEditor.add_child(testInstance)
	
	var fInstance = load("res://scenes/editor/static.tscn").instance()
	fInstance.set_pos(Vector2(1400, 700))
	fInstance.set_object_name("finish")
	fInstance.set_texture(resources.get_image("finish"))
	fInstance.set_z(-20)
	TestEditor.add_child(fInstance)
	
	get_node("HUD").get_node("SimulationButton").set_text("Start")
	
func replay():
	end_simulation()
	get_node("HUD").get_node("SimulationButton").set_text("Start")
	
func playback():
	replay = true
	var hud = get_node("HUD")
	hud.get_node("Platform").queue_free()
	hud.get_node("Conveyor").queue_free()
	
func test_save_level():
	var savefile = File.new()
	var savepath = "res://saves/testsave"+str(playtime)+".sav"
	savefile.open(savepath, File.WRITE)
	
	for o in currentLevel:
		savefile.store_string(o.to_json() + "\n")
		
	savefile.close()
	
	playtime = playtime + 1
	store_playtime()
	
func test_load_level(path):
	
	var loadlevel = []
	
	#open the test save.
	var savefile= File.new()
	#var savepath =  "res://saves/testsave.txt"
	savefile.open(path, File.READ)
	
	while(!savefile.eof_reached()):
		var object = {}
		object.parse_json(savefile.get_line())
		loadlevel.append(object)
		
	savefile.close()
	
	#remove the last object from loadlevel because of each line has a newline. 
	loadlevel.remove(loadlevel.size()-1)
	
	#remove the current objects in the world.
	var Editor = get_node("Editor")
	for N in Editor.get_children():
		N.free()
	
	#
	for o in loadlevel:
		var itemSpawn = load("res://scenes/editor/static.tscn").instance()
			
		itemSpawn.set_object_name(o.name)
		itemSpawn.set_texture(resources.get_image(o.name))
		var x_axis = Vector2(o.x_axis_x, o.x_axis_y)
		var y_axis = Vector2(o.y_axis_x, o.y_axis_y)
		var origin = Vector2(o.origin_x, o.origin_y)
		
		var transform = Matrix32(x_axis, y_axis, origin)
		
		itemSpawn.set_transform(transform)
		itemSpawn.set_z(-20)
		Editor.add_child(itemSpawn)
	

#Go do this in game scene
func start_simulation():
	simulating = true
	
	var Editor = get_node("Editor")
	var ObjectsInEditor = Editor.get_children()
	
	#store the items
	currentLevel.clear()
	
	for object in ObjectsInEditor:
		#store their position and item name.
		var storageObject = {
			"name" : object.get_object_name(),
			"transform" : object.get_transform(),
			"x_axis_x" : object.get_transform().x.x,
			"x_axis_y" : object.get_transform().x.y,
			"y_axis_x" : object.get_transform().y.x,
			"y_axis_y" : object.get_transform().y.y,
			"origin_x" : object.get_transform().o.x,
			"origin_y" : object.get_transform().o.y,
			#moet dit nu lelijk opslaan. Kijken of dit ook anders kan.
			"staticObject" : object.get_staticObject()
		}
		currentLevel.append(storageObject)
	
	#delete stuff.
	Editor.free()
	
	#add the simulation node
	var simulationInstance = load("res://scenes/worlds/simulation.tscn").instance()
	simulationInstance.set_name("Simulation")
	add_child(simulationInstance)
	
	#spawn the game items.
	var resources = get_node("/root/resources")
	var simulation = get_node("Simulation")
	
	for object in currentLevel:
		var objectInstance = resources.get_item_instance(object.name)
		objectInstance.set_transform(object.transform)
		simulation.add_child(objectInstance)
	
func is_simulating():
	return simulating
	
	#make this an editor function. 
func end_simulation():
	simulating = false
	
	#remove simulation.
	get_node("Simulation").free()
	
	#add editor to world and its items.
	var EditorInstance = load("res://scenes/worlds/editor.tscn").instance()
	add_child(EditorInstance)
	
	var Editor = get_node("Editor")
	#make this dynamic and check for static items but this can be done later.
	
	for o in currentLevel:
		var itemSpawn
		if(o.staticObject):
			itemSpawn = load("res://scenes/editor/static.tscn").instance()
		else:
			itemSpawn = load("res://scenes/editor/dragable.tscn").instance()
			
		itemSpawn.set_object_name(o.name)
		itemSpawn.set_texture(resources.get_image(o.name))
		var x_axis = Vector2(o.x_axis_x, o.x_axis_y)
		var y_axis = Vector2(o.y_axis_x, o.y_axis_y)
		var origin = Vector2(o.origin_x, o.origin_y)
		
		var transform = Matrix32(x_axis, y_axis, origin)
		itemSpawn.set_transform(transform)
		itemSpawn.set_z(-20)
		Editor.add_child(itemSpawn)
			
func win_level():
	#add_to_log("Won level 1")
	
	var  HUD = get_node("HUD")
	var winMessage = load("res://scenes/ui/WinMessage.tscn")
	var winInstance = winMessage.instance()
	
	#find beter location
	#1600 x 900
	winInstance.set_pos(Vector2(600,400))
	HUD.add_child(winInstance)
	
	if replay:
		winInstance.get_node("Panel").get_node("Button1").free()
	
	
	if !replay :
		var Log = get_node("/root/log")
		Log.save_log()
		test_save_level()
		#display the win message in hud.
		#save_log()