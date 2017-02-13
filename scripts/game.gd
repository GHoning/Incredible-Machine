extends Node

var simulating
var Level
var gOLocation = "res://scenes/game/"


func _ready():
	Level = get_node("Level");
	
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
			
func save():
	var savepath = "res://saves/"+get_node("/root/log").playername+"_savfile"+str(get_node("/root/log").startcounter)+".txt"
	var savegame = File.new()
	savegame.open(savepath, File.WRITE)
	for o in Level.get_children():
		if o.has_method("save"):
			var savedata = o.save()
			savegame.store_line(savedata.to_json())
	
	savegame.close()