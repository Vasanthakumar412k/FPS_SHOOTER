class_name Shooting_state
extends PlayerMovement

var rapid: bool = false
var released: bool = false
var running: bool = false

@export var aim: CenterContainer
@export var ANIM: AnimationPlayer

# cooldown timer (seconds until next shot)
var fire_cooldown: float = 0.0

func _ready() -> void:
	pass

func enter() -> void:
	running = true
	ANIM.play("aim", 1, 10)
	await ANIM.animation_finished
	running = false
	aim.visible = true
	Global.player.SPEED = 3

func normal() -> void:
	aim.visible = false
	ANIM.play("aim", -1, -10, true)
	await ANIM.animation_finished
	if !Global.player.is_crouching:
		transition.emit("Idle_state")
	elif Global.player.is_crouching:
		transition.emit("Crouch_state")

func _input(event):
	if event.is_action_pressed("fire"):
		rapid = true
	elif event.is_action_released("fire"):
		rapid = false
	elif event.is_action_released("aim") and !released and !running:
		rapid = false
		normal()

func _process(delta: float) -> void:
	# Handle exiting aim while still animating
	if Input.is_action_just_released("aim") and running and !Global.player.is_crouching:
		await ANIM.animation_finished
		normal()
	
	# --- Cooldown handling ---
	if fire_cooldown > 0:
		fire_cooldown -= delta

	# --- Rapid fire logic ---
	if rapid and fire_cooldown <= 0 and Global.CURRENT_STATE == "Shooting_state":
		Global.ATTACK._attack()
		
		# Convert rate_of_fire (bullets per second) into cooldown time
		# Example: rate_of_fire = 5 → cooldown = 0.2s between shots
		fire_cooldown = 1.0 / max(Global.rate_of_fire, 0.01)
