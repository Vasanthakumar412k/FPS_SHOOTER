class_name Shooting_state extends PlayerMovement

var rapid=false
var released=false
var running=false
@export var aim:CenterContainer
@export var ANIM:AnimationPlayer
func _ready() -> void:
	pass 
func enter()->void:
	running=true
	ANIM.play("aim",1,10)
	await ANIM.animation_finished
	running=false
	aim.visible=true
	Global.player.SPEED=3
	
	
func normal():
	aim.visible=false
	ANIM.play("aim",-1,-10,true)
	await ANIM.animation_finished
	transition.emit("Idle_state")
func _input(event):
	if event.is_action_pressed('fire'):
		rapid=true
	if event.is_action_released("fire"):
		rapid=false
	if event.is_action_released("aim") and !released and !running:
		rapid=false
		normal()

var okay=true
func _process(delta: float) -> void:
	if Input.is_action_just_released("aim") and running:
		await ANIM.animation_finished
		normal()
		
	if rapid and Global.CURRENT_STATE=="Shooting_state":
		if okay:
			okay=false
			Global.ATTACK._attack()
			await get_tree().create_timer(Global.rate_of_fire).timeout
			if okay==false:
				okay=true
