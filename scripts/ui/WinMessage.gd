
extends Control

func _on_Button_pressed():
	var game = get_tree().get_root().get_node("World").get_node("Game")
	game.replay()
	queue_free()

func _on_Button1_pressed():
	var game = get_tree().get_root().get_node("World").get_node("Game")
	game.end_simulation()
	game.restart_level()
	queue_free()

