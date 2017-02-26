extends HBoxContainer

var logPath
var fileName

func set_path(logpath, filename):
	get_node("RichTextLabel").set_bbcode(filename)
	logPath = logpath
	fileName = filename

func _on_Replay_pressed():
	print("clicked replay")
	var replay = load("res://scenes/replay.tscn").instance()
	get_parent().get_parent().get_parent().get_parent().add_child(replay)
	var savefilename = fileName.replace("logfile", "savefile")
	savefilename = savefilename.replace("log", "sav")
	replay.load_level("res://saves/" + savefilename)
	get_parent().get_parent().get_parent().queue_free()

func _on_Timeline_pressed():
	var timeline = load("res://scenes/ui/timeline_widget.tscn").instance()
	get_parent().get_parent().get_parent().set_timeline(true)
	get_parent().get_parent().add_child(timeline)
	timeline.create_timeline(logPath + fileName)
	get_parent().queue_free()