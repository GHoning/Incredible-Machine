extends Node2D

export(int, "MOVEOBJECT", "TURINGOBJECT", "NORMAL") var mousemode

export(Texture) var texture_M
export(Texture) var texture_T
export(Texture) var texture_N

var sprite
var offset

func _ready():
	set_process_input(true)
	sprite = get_node("Sprite")
	sprite.set_texture(texture_N)
	#offset = Vector2(sprite.get_texture().get_height() / 2, sprite.get_texture().get_width() / 2)
	#offset = Vector2(20, 20)
	
func _input(event):
	if(event.type == InputEvent.MOUSE_MOTION):
		offset = Vector2(sprite.get_texture().get_height() / 2, sprite.get_texture().get_width() / 2)
		set_pos(event.pos + offset)
		

func set_moveObject():
	sprite.set_texture(texture_M)
	
func set_turnObject():
	sprite.set_texture(texture_T)
	
func set_Normal():
	sprite.set_texture(texture_N)