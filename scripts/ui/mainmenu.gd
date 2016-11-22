extends VBoxContainer

func _on_Game_Button_pressed():
	var game = load("res://scenes/game.scn").instance()
	get_parent().add_child(game)
	game.restart_level()
	queue_free()

func _on_Dash_Button_pressed():
	var dash = load("res://scenes/dashboard.tscn").instance()
	get_parent().add_child(dash)
	queue_free()