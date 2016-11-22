extends Area2D

func _on_Area2D_body_enter( body ):
	#finish the level adn add to the log that the level was complete succesfully
	
	if(body.get_name() == "ball"):
		
		
		var Log = get_node("/root/log")
		Log.add_to_log("Ball reached box")
		
		var game = get_tree().get_root().get_node("World").get_node("Game")
		game.win_level()