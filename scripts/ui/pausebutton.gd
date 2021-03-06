extends Button

func _pressed():
	var game = get_tree().get_root().get_node("World").get_node("Game")
	var Log = get_node("/root/log")
	
	if(game.is_simulating()):
		Log.add_to_log("Ended Simulation")
		game.end_simulation()
		set_text("Start")
	else:
		Log.add_to_log("Started Simulation")
		game.start_simulation()
		#put these on if you want the game to save the stored information.
		game.save()
		Log.save_log()
		set_text("Stop")