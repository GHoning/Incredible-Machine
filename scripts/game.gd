extends Node

var simulating
var Level
var gOLocation = "res://scenes/game/"
var Win


func _ready():
	Level = get_node("Level");
	Level.queue_free()
	
	var level1 = load("res://scenes/levels/Level1.tscn").instance()
	level1.set_name("Level")
	add_child(level1)
	
	for o in get_children():
		print(o.get_name())
	
	Level = get_node("@Level@9")
		
func win_level():
	var win = load("res://scenes/ui/win_widget.tscn").instance()
	add_child(win)
	
func play_level2():
	end_simulation()
	#reset text on start button
	get_node("HUD").get_node("SimulationButton").set_text("Start")
	Level.queue_free()
	var level2 = load("res://scenes/levels/Level2.tscn").instance()
	level2.set_name("Level")
	add_child(level2)
	
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
	var savepath = "res://saves/"+get_node("/root/log").playername+"_savfile"+str(get_node("/root/log").startcounter)+".txt"
	var savegame = File.new()
	savegame.open(savepath, File.WRITE)
	for o in Level.get_children():
		if o.has_method("save"):
			var savedata = o.save()
			savegame.store_line(savedata.to_json())
	
	savegame.close()