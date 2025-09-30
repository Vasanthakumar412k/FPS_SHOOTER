class_name Sprint_state extends PlayerMovement

@export var ANIMATION_SPEED:float=3

func _input(event):
	if event.is_action_released("sprint") and Global.CURRENT_STATE!="Crouch_state" and Global.player.is_on_floor() and Global.CURRENT_STATE!="Shooting_state":
		transition.emit("Walking_state")
	if event.is_action_pressed("jump") and Global.player.is_on_floor():
		transition.emit("Jump_state")
		
func enter() -> void:
	ANIMATION.play("walking", -1, ANIMATION_SPEED)
	Global.player.SPEED=Global.player.SPRINT_SPEED 
	

func update(delta):
	set_animation_speed(Global.player.velocity.length())

func set_animation_speed(spd):
	var alpha = remap(ANIMATION_SPEED, 0.0, Global.player.SPRINT_SPEED, 0.0, 1.0)
	ANIMATION.speed_scale=lerp(0.0,ANIMATION_SPEED,alpha)
