class_name Crouch
extends PlayerMovement

@export var ACCELERATION: float = 1.0
@export var DECELERATION: float = 1.
@export var SPEED: float = 2.0
@export var CROUCH_ANIM_SPEED: float = 2
var PSPEED
func enter():
	ANIMATION.play("crouch", -1, CROUCH_ANIM_SPEED) 
	PSPEED=Global.player.SPEED
	Global.player.SPEED=SPEED
	Global.player.is_crouching=true

func update(delta):
	if not(ANIMATION.is_playing()) and Input.is_action_just_pressed("crouch"):
		uncrouch()
	if Input.is_action_pressed("fire"):
		Global.ATTACK._attack()
	if Input.is_action_pressed("aim"):
		transition.emit("Shooting_state")
		
func uncrouch():
	ANIMATION.play("crouch", -1, -CROUCH_ANIM_SPEED, true)
	await ANIMATION.animation_finished
	Global.player.is_crouching=false
	Global.player.SPEED=PSPEED
	transition.emit("Idle_state")


	
