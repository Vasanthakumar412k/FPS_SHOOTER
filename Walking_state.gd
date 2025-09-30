class_name Walking_state extends PlayerMovement

@export var TOP_ANIM_SPEED:float=1.5
var okay=true

func enter()->void:
	
	ANIMATION.play("walking",-1,TOP_ANIM_SPEED)
	Global.player.SPEED=Global.player.DEFAULT_SPEED
	

func _input(event):
	if event.is_action_pressed("sprint") and Global.CURRENT_STATE!="Crouch_state" and Global.player.is_on_floor() and Global.CURRENT_STATE!="Shooting_state":
		transition.emit("Sprint_state")
	if event.is_action_pressed("jump") and Global.player.is_on_floor():
		transition.emit("Jump_state")
	if event.is_action_pressed("aim"):
		transition.emit("Shooting_state")

	
func exit():
	ANIMATION.speed_scale=1.0
	ANIMATION.stop()
func update(delta):
	set_animation_speed(Global.player.velocity.length())
	if Input.is_action_just_pressed("crouch") and PLAYER.is_on_floor():
		transition.emit("Crouch_state")
	if Global.player.velocity.length()==0:
		transition.emit("Idle_state")
	


func set_animation_speed(spd):
	var alpha=remap(spd,0.0,Global.player.SPEED,0.0,1.0)
	ANIMATION.speed_scale=lerp(0.0,float(TOP_ANIM_SPEED),float(alpha))
