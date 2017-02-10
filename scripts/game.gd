extends Node

var simulating = false
var replay = false
var currentLevel = []
var world
var playtime


var Level
var gOLocation = "res://scenes/game/"

func _ready():
	print("Start game")
	#add stuff to scene here. Delete teh editor. From the scene first. 
	#It is now called level. Fuck the editor and game mode. Just tell the items do their stuff.
	#Not sure if I still need the Storage node. I'll leave it for now.
	#add three test items.
	Level = get_node("Level");
	
	#ball
	var ball = load(gOLocation + "ball.scn").instance()
	#can't do that because of rigidbody2d in ball.
	ball.set_pos(Vector2(500, 300))
	Level.add_child(ball);
	
	#tampoline
	var tramp = load(gOLocation + "bounce.tscn").instance()
	tramp.set_pos(Vector2(500, 500))
	Level.add_child(tramp)
	
	#Pipe
	var pipe = load(gOLocation + "pipe.tscn").instance()
	pipe.set_pos(Vector2(500, 100))
	Level.add_child(pipe)
	
	
	
	
	
	
	
	
	
	
	
	
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
	for o in Level.get_children():
		if o.has_method("startSimulating"):
			print(o.get_name())
			o.startSimulating()
	
	
func is_simulating():
	return simulating

func end_simulation():
	simulating = false
	for o in Level.get_children():
		if o.has_method("endSimulating"):
			o.endSimulating()