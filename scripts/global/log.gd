extends Node

var playername = "default"
var startcounter = 0
var Log= []

func set_player_name(s):
	playername = s

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
	var logfile = File.new()
	#"+playername+"/
	var logpath = "res://logs/"+playername+"_logfile"+str(startcounter)+".log"
	logfile.open(logpath, File.WRITE)
	
	for line in Log:
		logfile.store_string(line)
		
	logfile.close()
	
	clear_log()
	startcounter = startcounter + 1