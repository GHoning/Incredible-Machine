extends VBoxContainer

var logfile
var textfield

func _ready():
	logfile = get_node("/root/log")
	textfield = get_node("TextEdit")
	textfield.set_text(logfile.playername)

func _on_Game_Button_pressed():
	logfile.set_player_name(textfield.get_text())
	
	var game = load("res://scenes/game.tscn").instance()
	get_parent().add_child(game)
	queue_free()

func _on_Dash_Button_pressed():
	var dash = load("res://scenes/dashboard.tscn").instance()
	get_parent().add_child(dash)
	queue_free()