class_name StateMachine

extends Node

var states:Dictionary={}

@export var CURRENT_STATE:State

func _ready():
	Global.CURRENT_STATE=CURRENT_STATE.name
	for i in get_children():
		if i is State:
			states[i.name]=i
			i.transition.connect(_add_state_transition)
		else:
			push_warning("invalid node found in the statemachine")
	print(states)
func _process(delta):
	CURRENT_STATE.update(delta)
	Global.debug._add_debug_property("STATE",CURRENT_STATE.name,3)
	

func _physics_process(delta):
	CURRENT_STATE.physics_update(delta)
	
func _add_state_transition(new_state_name:String):
	var new_state=states.get(new_state_name)
	if new_state!=null:
		if new_state!=CURRENT_STATE:
			CURRENT_STATE.exit()
			new_state.enter()
			CURRENT_STATE=new_state
			Global.CURRENT_STATE=CURRENT_STATE.name
	else:
		push_warning("invalid state")
	
