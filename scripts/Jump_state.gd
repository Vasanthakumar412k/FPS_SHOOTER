class_name Jump_State extends PlayerMovement

var JUMP_VELOCITY = 8

func enter():
	Global.player.velocity.y+=JUMP_VELOCITY
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
func update(delta):
	
	if Global.player.velocity.y==0 and Global.player.is_on_floor() and Global.CURRENT_STATE!="Shooting_state":
		transition.emit("Idle_state")
	if Input.is_action_pressed("aim"):
		transition.emit("Shooting_state")
	
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
