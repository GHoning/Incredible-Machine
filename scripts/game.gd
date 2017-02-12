extends Node

var simulating
var Level
var gOLocation = "res://scenes/game/"

func _ready():
	Level = get_node("Level");
	
func is_simulating():
	return simulating

#these are called from hud
func start_simulation():
	simulating = true
	for o in Level.get_children():
		if o.has_method("start"):
			o.start()

func end_simulation():
	simulating = false
	for o in Level.get_children():
		if o.has_method("end"):
			o.end()