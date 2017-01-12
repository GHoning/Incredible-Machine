extends Node

var Objects = [	{	
					name = "ball",
					scene = "res://scenes/game/ball.scn",
					ui_image = "res://assets/items/ball.png",
					asset = "res://assets/items/ball.png",
					config = {
						weight = 0
					}
				}, {
					name = "platform",
					scene = "res://scenes/game/platform.tscn",
					ui_image = "res://assets/items/platform.png",
					asset = "res://assets/items/platform.png",
					config = {
						length = 10
					}
				}, {
					#remove this for an end level trigger later
					name = "finish",
					scene = "res://scenes/game/EndField.tscn",
					ui_image = "res://assets/items/finishline.png",
					asset =  "res://assets/items/finishline.png",
				}, {
					name = "conveyor",
					scene = "res://scenes/game/conveyor.tscn",
					ui_image = "res://assets/items/conveyor.png",
					asset =  "res://assets/items/conveyor.png",
					config = {
						length = 0
					}
				}]

func get_item_instance(itemName):
	for object in Objects:
		if(object.name == itemName):
			return load(object.scene).instance()
			
func get_ui(itemName):
	for object in Objects:
		if(object.name == itemName):
			return load(object.ui_image)
			
func get_image(itemName):
	for object in Objects:
		if(object.name == itemName):
			return load(object.asset)
			
func get_config(itemName):
	for object in Objects:
		if(object.name == itemName):
			return object.config