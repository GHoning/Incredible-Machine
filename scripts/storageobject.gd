extends Node

var stored_name
var stored_transform
var bStaticObject
var config

func setupObject(name, transform, staticObject, configuration):
	stored_name = name
	stored_transform = transform
	bStaticObject = staticObject
	config = configuration

# ugly "_stored_" thing because otherwise it would be a base function of node.
func get_stored_name():
	return stored_name

func get_stored_transform():
	return stored_transform

func get_config():
	return config
	
func get_staticObject():
	return bStaticObject
	
func get_save_dict():
	# Shit doesn't work for me because of the config. So not sure how to solve this now.
	var savedict = {
		name = stored_name,
		staticObject = bStaticObject,
		xx = stored_transform.x.x,
		xy = stored_transform.x.y,
		yx = stored_transform.y.x,
		yy = stored_transform.y.y,
		ox = stored_transform.o.x,
		oy = stored_transform.o.y
		}
	#will use an other dict for the config.
	return savedict