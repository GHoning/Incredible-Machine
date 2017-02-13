extends Node

var simulating
var Level
var gOLocation = "res://scenes/game/"
var Win
	
	
func win_level():
	var win = load("res://scenes/ui/win_widget.tscn").instance()
	add_child(win)
	
func play_level1():
	Level = get_node("Level");
	Level.free()
	
	var level1 = load("res://scenes/levels/Level1.tscn").instance()
	level1.set_name("Level")
	add_child(level1)
	
	get_node("/root/log").set_level_name("Level1")
	
	for o in get_children():
		print(o.get_name())
	
	Level = get_node("Level")
	
	
func play_level2():
	Level = get_node("Level");
	Level.free()
	
	var level2 = load("res://scenes/levels/Level2.tscn").instance()
	level2.set_name("Level")
	add_child(level2)
	
	get_node("/root/log").set_level_name("Level2")
	
	for o in get_children():
		print(o.get_name())

	Level = get_node("Level")
	
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
	var savepath = "res://saves/"+get_node("/root/log").playername+"_"+get_node("/root/log").levelname+"_savfile"+str(get_node("/root/log").startcounter)+".txt"
	var savegame = File.new()
	savegame.open(savepath, File.WRITE)
	for o in Level.get_children():
		if o.has_method("save"):
			var savedata = o.save()
			savegame.store_line(savedata.to_json())
	
	savegame.close()