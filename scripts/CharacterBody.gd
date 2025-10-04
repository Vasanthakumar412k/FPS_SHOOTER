class_name Player extends CharacterBody3D
var DEFAULT_SPEED=5
var SPEED = 5

@export var JUMP_VELOCITY=5.0
@export var CROUCH_SPEED:=7.0
@export var SPRINT_SPEED=7
@export var TILT_LOWER_LIMIT := deg_to_rad(-30.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(80.0)
@export var CAMERA_CONTROLLER: Camera3D
@export var CAMERA_PIVOT: Node3D  # The new pivot node for tilt
@export var ANIM:AnimationPlayer 
@export var acceleration:float=0.1
@export var deceleration:float=0.25
@onready var spotlight=$Pivot/SpotLight3D
var _mouse_rotation := Vector2.ZERO
var _rotation_input: float = 0.0
var _tilt_input: float = 0.0
var is_crouching=false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.player=self

func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().quit()
#	if event.is_action_pressed("crouch"):
#		crouch()
	if event.is_action_pressed("torch"):
		spotlight.visible=!spotlight.visible

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_rotation_input = -event.relative.x
		_tilt_input = -event.relative.y

func _update_camera(delta):
	
	_mouse_rotation.x += _tilt_input * delta * 0.3  # Vertical (pitch)
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)

	_mouse_rotation.y += _rotation_input * delta * 0.3  # Horizontal (yaw)

	# Apply vertical tilt to camera pivot
	if CAMERA_PIVOT:
			CAMERA_PIVOT.rotation.x = _mouse_rotation.x
	# Apply horizontal rotation to character
	rotation.y = _mouse_rotation.y

	_rotation_input = 0.0
	_tilt_input = 0.0
#var is_crouching=false
#func crouch():
#	if is_crouching:
#		ANIM.play("crouch",-1,-CROUCH_SPEED,true)
#	elif not(is_crouching):
#		ANIM.play("crouch",-1,CROUCH_SPEED)
#	is_crouching=!is_crouching


func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
#
#	if Input.is_action_just_pressed("jump") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
	var input_dir = Input.get_vector("a", "d", "w", "s")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if Input.is_action_pressed("clear"):
		velocity.y=-5
	if Input.is_action_just_released("clear"):
		velocity.y=0
	if direction:
		velocity.x = lerp(velocity.x,direction.x*SPEED,acceleration)
		velocity.z = lerp(velocity.z,direction.z*SPEED,acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)

	move_and_slide()
	_update_camera(delta)
func _process(delta):
	Global.debug._add_debug_property("VELOCITY",velocity.length(),2)
	Global.debug._add_debug_property("POSITION",position,4)
	Global.debug._add_debug_property("CROUCHING",is_crouching,8)
	
