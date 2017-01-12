extends RigidBody2D

#if hit by a something. Get scared. And starts running.

var powered = false
var time = 30
var connectingbodies = []
var timer = Timer.new()

func _ready():
	timer.connect("timeout", self, "_timer_finished")
	timer.set_one_shot(true)
	add_child(timer)

func _get_powered():
	return powered

func _timer_finished():
	powered = false
	
func _integrate_forces(state):
	pass
	#print("statecontact ",state.get_contact_count())
	#print("connectbodies ",connectingbodies.size())

	#if(!state.get_contact_count() == connectingbodies.size() && !connectingbodies.size() == 0):
		#connectingbodies.clear()
		#print("Clear")

func _on_RigidBody2D_body_enter(body):
	#returns -1 if object not in array
	if connectingbodies.find(body.get_name()) < 0 :
		#check if new hit
		connectingbodies.append(body.get_name())
		#add the object to the list
		powered = true
		timer.stop()
		timer.set_wait_time(time)
		timer.start()