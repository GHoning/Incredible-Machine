extends Button

func _pressed():
	get_parent().get_parent().is_simulating()
	
	if(get_parent().get_parent().is_simulating()):
		get_parent().get_parent().end_simulation()
		set_text("Start")
	else:
		get_parent().get_parent().start_simulation()
		set_text("Stop")