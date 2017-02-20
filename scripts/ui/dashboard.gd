extends Node

const logdirectory = "res://logs"

var timelineactive = false

func set_timeline(b):
	timelineactive = b

func _ready():
	
	var logfiles = list_files_in_directory(logdirectory)
	logfiles.sort()
	
	for f in logfiles:
		var replaywidget = load("res://scenes/ui/replay_widget.tscn").instance()
		get_node("ScrollContainer/VBoxContainer").add_child(replaywidget)
		replaywidget.set_path(logdirectory + "/", f)
	
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
	
	if timelineactive :
		get_node("ScrollContainer").get_children()[2].free()
		var logfiles = list_files_in_directory(logdirectory)
		logfiles.sort()
		
		var Vbox = VBoxContainer.new()
		
		for f in logfiles:
			var replaywidget = load("res://scenes/ui/replay_widget.tscn").instance()
			Vbox.add_child(replaywidget)
			replaywidget.set_path(logdirectory + "/", f)
			
		get_node("ScrollContainer").add_child(Vbox)
		timelineactive = false
		
	else:
		#go back to main menu.
		var menu = load("res://scenes/main_menu.tscn").instance()
		get_parent().add_child(menu)
		queue_free()