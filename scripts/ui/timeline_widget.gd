extends VBoxContainer

var path

func create_timeline(logpath):
	var timeline = get_node(".")
	var logfile = File.new()
	logfile.open(logpath, File.READ)
	
	while(!logfile.eof_reached()):
		var logline = logfile.get_line()
		if !logline.length() == 0 :
			var event = load("res://scenes/ui/event_widget.tscn").instance()
			timeline.add_child(event)
			event.set_bbcode(logline)
		
	logfile.close()