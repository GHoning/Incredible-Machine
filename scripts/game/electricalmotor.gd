extends Node

var connectedTo

func _plugin(node):
	connectedTo = node

func _get_powered():
	if connectedTo.hasMethod("_has_power"):
		connectedTo._has_power()
	else:
		return false