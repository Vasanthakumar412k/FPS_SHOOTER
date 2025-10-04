class_name Idle_state
extends PlayerMovement

func enter():
	if ANIMATION:
	
		ANIMATION.pause()

func update(delta):
	if PLAYER.velocity.length() > 0 and PLAYER.is_on_floor():
		transition.emit("Walking_state")
	elif Input.is_action_just_pressed("crouch") and PLAYER.is_on_floor():
		transition.emit("Crouch_state")
	elif Input.is_action_just_pressed("jump") and PLAYER.is_on_floor():
		transition.emit("Jump_state")
	if Input.is_action_pressed("aim"):
		transition.emit("Shooting_state")
	if Input.is_action_pressed("sprint") and PLAYER.is_on_floor() and Global.CURRENT_STATE!="Shooting_state":
		transition.emit("Sprint_state")
	
		
		
		
		
		
