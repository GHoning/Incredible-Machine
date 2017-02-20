extends Node

var simulating
var Level
var gOLocation = "res://scenes/game/"
var Win


func regen_savefile_from_logfile():
	print(get_node("/root/log").levelname)
	var logdirectory = "res://logs"
	var logfiles = list_files_in_directory(logdirectory)
	logfiles.sort()
	for f in logfiles:
		#check if the log file is for the current level
		if f.find(get_node("/root/log").levelname) > 0 :
			print(f," succeed")
			var logfile = File.new()
			print(logdirectory + "/" + f)
			logfile.open(logdirectory + "/" + f, File.READ)
		
			while !logfile.eof_reached():
				var logline = logfile.get_line()
				if !logline.length() == 0 :
					if logline.find("Moved") > 0 :
						#print("Moved a object " + logline)
					
						var foundGameItems = get_objects_in_string(logline)
						var object = fined_longest_name(foundGameItems)
						
						#print(object.get_name())
					
						#retreive number from log string
						var x = logline.find_last("(")
						var y = logline.find_last(")")
						#add onoe before using it as the iterator to get the numbers between "()"
						x = x + 1
						var stringX = ""
						var stringY = ""
						var split = false
					
						while x != y :
							if logline[x] == ",": 
								split = true
								
							if !split:
								stringX = stringX + logline[x]
							else: 
								stringY = stringY + logline[x]
								
							x = x + 1
						
						#remove ", "W
						stringY.erase(0, 2) 
						#move the objects
						object.set_global_pos(Vector2(stringX.to_float(), stringY.to_float()))
						
					elif logline.find("rotated") > 0:
						#print ("Rotated a object " + logline)
						var foundGameItems = get_objects_in_string(logline)
						#print(foundGameItems)
						var object = fined_longest_name(foundGameItems)
						#print(object)
						var x = logline.find_last(" ")
						x = x + 1
						var y = logline.length()
						var string = ""
					
						while x != y :
							string = string + logline[x]
							x= x + 1
					
						#print(object.get_rot(), object.get_name())
						#print(string)
						#add the offset added in level 2.
						if object.get_name() == "pipe_booster 3" :
							object.set_rot(string.to_float() + deg2rad(90))
						elif object.get_name() == "pipe_corner 5":
							object.set_rot(string.to_float() + deg2rad(270))
						elif object.get_name() == "pipe_corner 6": 
							object.set_rot(string.to_float() + deg2rad(270))
						else :
							object.set_rot(string.to_float())
						
						#print(object.get_rot())
					
					else :
						pass
						#print("No editing of line ", logline)
		
			#end of while
			logfile.close()
			resave(f)
		
func get_objects_in_string(string):
	var array = []
	for o in Level.get_children():
		if string.find(o.get_name()) > 1 :
			array.append(o)
	
	return array
	
func fined_longest_name(array):
	var returnString = array[0].get_name()
	var object = array[0]
	
	for o in array :
		if o.get_name().length() > returnString.length():
			returnString = o.get_name()
			object = o
			
	return object
	
func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)
			
	dir.list_dir_end()
		
	return files
	
	


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
	print(get_node("/root/log").levelname)
	
	Level = get_node("Level")
	
	
func play_level2():
	Level = get_node("Level");
	Level.free()
	
	var level2 = load("res://scenes/levels/Level2.tscn").instance()
	level2.set_name("Level")
	add_child(level2)
	
	get_node("/root/log").set_level_name("Level2")
	print(get_node("/root/log").levelname)
	

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
			
func resave(f):
	var savefilename = f.replace("logfile", "savefile")
	savefilename = savefilename.replace("log", "sav")
	
	
	var savepath = "res://saves/" + savefilename
	var savegame = File.new()
	savegame.open(savepath, File.WRITE)
	for o in Level.get_children():
		if o.has_method("save"):
			var savedata = o.save()
			savegame.store_line(savedata.to_json())
	
	savegame.close()
			
			
func save():
	var savepath = "res://saves/"+get_node("/root/log").playername+"_"+get_node("/root/log").levelname+"_savfile"+str(get_node("/root/log").startcounter)+".txt"
	var savegame = File.new()
	savegame.open(savepath, File.WRITE)
	for o in Level.get_children():
		if o.has_method("save"):
			var savedata = o.save()
			savegame.store_line(savedata.to_json())
	
	savegame.close()