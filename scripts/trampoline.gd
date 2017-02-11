#extends "gameObject.gd"
extends Node2D

var isSimulating = false
var rigidbody

func _ready():
	rigidbody = get_node("RigidBody2D")
	rigidbody.dragable_on()

func startSimulating():
	isSimulating = true
	rigidbody.dragable_off()
	
func endSimulating():
	isSimulating = false
	rigidbody.dragable_on()