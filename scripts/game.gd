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
	testInstance.set_pos(Vector2(500, 200))
	testInstance.set_object_name("ball")
	testInstance.set_texture(resources.get_image("ball"))
	testInstance.set_z(-20)
	TestEditor.add_child(testInstance)
	
	var fInstance = load("res://scenes/editor/static.tscn").instance()
	fInstance.set_pos(Vector2(1070, 700))
	fInstance.set_object_name("finish")
	fInstance.set_texture(resources.get_image("finish"))
	fInstance.set_z(-20)
	TestEditor.add_child(fInstance)
	
	get_node("HUD").get_node("SimulationButton").set_text("Start")
	
	var Bounce = load("res://scenes/editor/static.tscn").instance()
	#var resources = get_node("/root/resources")
	Bounce.set_pos(Vector2(520, 700))
	Bounce.set_object_name("bounce")
	Bounce.set_texture(resources.get_image("bounce"))
	Bounce.set_z(-20)
	#Pipe.set_rot(deg2rad(90))
	#Pipe.set_scale(Vector2(2,2))
	TestEditor.add_child(Bounce)
	
	var Pipe = load("res://scenes/editor/static.tscn").instance()
	#var resources = get_node("/root/resources")
	Pipe.set_pos(Vector2(500, 100))
	Pipe.set_object_name("pipe")
	Pipe.set_texture(resources.get_image("pipe"))
	Pipe.set_z(-20)
	#Pipe.set_rot(deg2rad(90))
	#Pipe.set_scale(Vector2(2,2))
	TestEditor.add_child(Pipe)
	
	
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
	var savepath = "res://saves/newsave.savx"
	savefile.open(savepath, File.WRITE)
	
	for o in get_node("Storage").get_children() :
		print(o.get_save_dict(), o.get_config())
		savefile.store_line(o.get_save_dict().to_json())
		savefile.store_line(o.get_config().to_json())
	
	savefile.close()
#	
#	playtime = playtime + 1
#	store_playtime()
	
func test_load_level():
	
	var loadlevel = []
	
	#open the test save.
	var savefile= File.new()
	var savepath =  "res://saves/newsave.savx"
	var loadArray = []
	savefile.open(savepath, File.READ)
	while(!savefile.eof_reached()):
		var newdict = {}
		newdict.parse_json(savefile.get_line())
		loadArray.append(newdict)
	savefile.close()
	
	print(loadArray)
	
	for o in get_node("Storage").get_children() :
		o.free()
		
	print("Storage cleared")
	
	for i in range(0, loadArray.size()-1, 2):
		print("in loop wtf")
		var storageObject = load ("res://scenes/storageobject.tscn").instance()
		var x_axis = Vector2(loadArray[i].xx, loadArray[i].xy)
		var y_axis = Vector2(loadArray[i].yx, loadArray[i].yy)
		var origin = Vector2(loadArray[i].ox, loadArray[i].oy)
		storageObject.setupObject(loadArray[i].name, Matrix32(x_axis, y_axis, origin), loadArray[i].staticObject, loadArray[i+1])
		get_node("Storage").add_child(storageObject)
		
	#clear the Editor Instance
	for p in get_node("Editor").get_children():
		p.free()
		
	get_node("Editor").load_level(get_node("Storage"))
	

#Store the current items in Editor and stores them. Then passes that to the simulation.
#Maybe move this to the game.
func start_simulation():
	simulating = true
	
	var Editor = get_node("Editor")
	
	#clear the storage object. Implement a version later that checks if a certain item hasn't changed
	for child in get_node("Storage").get_children():
		child.free()
	
	#store the objects from the editor
	for object in Editor.get_children():
		#create the storage object
		var storageObject = load("res://scenes/storageobject.tscn").instance()
		object.set_config({
			test = "Thomas is een beetje zielig"
		})
		storageObject.setupObject(object.get_object_name(), object.get_transform(), object.get_staticObject(), object.get_config())
		get_node("Storage").add_child(storageObject)
	
	#Delete editor mode
	Editor.free()
	
	#add the simulation mode
	var simulationInstance = load("res://scenes/worlds/simulation.tscn").instance()
	simulationInstance.set_name("Simulation")
	add_child(simulationInstance)
	simulationInstance.load_level(get_node("Storage"))
	
func is_simulating():
	return simulating

func end_simulation():
	simulating = false
	
	#remove simulation.
	get_node("Simulation").free()

	#add editor to world and its items.
	var EditorInstance = load("res://scenes/worlds/editor.tscn").instance()
	add_child(EditorInstance)
	EditorInstance.load_level(get_node("Storage"))



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