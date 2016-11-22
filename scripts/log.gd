extends Node

var Log= []

#adds the happening to an array of strings.
func add_to_log(string):
	#returns an array with ints.
	var time = OS.get_time(false).values()
	var hours = time[1]
	var minute = time[2]
	var seconds = time[0]
	Log.append(str(hours)+":"+str(minute)+":"+str(seconds) + " | " + string+"\n")

#clear the log for when we need it.
func clear_log():
	Log.clear()
	
#save the current Log Array in to a .txt file
func save_log():
	var game = get_tree().get_root().get_node("World").get_node("Game")
	
	var logfile = File.new()
	var logpath = "res://logs/logfile"+str(game.playtime)+".log"
	logfile.open(logpath, File.WRITE)
	
	for line in Log:
		logfile.store_string(line)
		
	logfile.close()