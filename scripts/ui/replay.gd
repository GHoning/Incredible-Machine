extends HBoxContainer

var logPath
var savefilenumber

func _ready():
	pass
	
func set_path(input, number):
	get_node("RichTextLabel").set_bbcode(input)
	logPath = input
	savefilenumber = number

func _on_Replay_pressed():
	#load in the game.
	var game = load("res://scenes/game.scn").instance()
	get_parent().get_parent().get_parent().add_child(game)
	game.test_load_level("res://saves/testsave"+ str(savefilenumber) +".sav")
	game.playback()
	
	get_parent().get_parent().queue_free()


func _on_Timeline_pressed():
	var timeline = load("res://scenes/ui/timelinewidget.tscn").instance()
	get_parent().get_parent().add_child(timeline)
	timeline.create_timeline(logPath)
	get_parent().queue_free()
