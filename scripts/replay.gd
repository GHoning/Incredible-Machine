extends Node

var simulating
var Level
var gOLocation = "res://scenes/game/"
var Win

var conveyor
var hamster
var rubberband
	
func load_level(save):
	Level = get_node("Level")
	print(save)
	
	var savegame = File.new()
	
	if !savegame.file_exists(save):
		return
	
	var currentDict = {}
	savegame.open(save, File.READ)
	#print(savegame.get_as_text())
	
	while(!savegame.eof_reached()):
		currentDict.parse_json(savegame.get_line())
		
		var newobject = load(currentDict["filename"]).instance()
		newobject.staticObject = true
		newobject.set_pos(Vector2(currentDict["posX"],currentDict["posY"]))
		newobject.set_rot(currentDict["rot"])
		newobject.set_scale(Vector2(currentDict["scalex"], currentDict["scaley"]))
		
		if currentDict["filename"] == "res://scenes/game/hamster_cage.tscn" or currentDict["filename"] == "res://scenes/game/conveyor.tscn":
			newobject.rubname = currentDict["rubberband"]
		elif currentDict["filename"] == "res://scenes/game/rubberband.tscn":
			newobject.name_object1 = currentDict["sobject1"]
			newobject.name_object2 = currentDict["sobject2"]
			
		
		#see if object is a rubberband conveyor or hamster then do stuff special for those items.
		Level.add_child(newobject)
		
	savegame.close()
		
	
func win_level():
	var win = load("res://scenes/ui/win_widget.tscn").instance()
	add_child(win)
	
func is_simulating():
	return simulating

#these are called from hud
func start_simulation():
	simulating = true
	for o in Level.get_children():
		if o.has_method("start"):
			o.start()

func end_simulation():
	simulating = false
	for o in Level.get_children():
		if o.has_method("end"):
			o.end()