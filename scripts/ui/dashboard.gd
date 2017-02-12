extends Node

const logdirectory = "res://logs"

func _ready():
	var logfiles = list_files_in_directory(logdirectory)
	
	#sort the files makes it looks much nicer
	logfiles.sort()
	
	for f in logfiles:
		
		var replaywidget = load("res://scenes/ui/replay.tscn").instance()
		get_node("VBoxContainer").add_child(replaywidget)
		replaywidget.set_path(logdirectory + "/"+ f, logfiles.find(f) + 1)
		
		#spawn a widget to display the time line.
		#var timeline = load("res://scenes/ui/timelinewidget.tscn").instance()
		#get_node("VBoxContainer").add_child(timeline)
		#pass it the log file I want it to display
		#timeline.create_timeline(logdirectory + "/" + f)
	
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

func _on_Back_Button_pressed():
	#go back to main menu.
	var menu = load("res://scenes/main_menu.tscn").instance()
	get_parent().add_child(menu)
	queue_free()