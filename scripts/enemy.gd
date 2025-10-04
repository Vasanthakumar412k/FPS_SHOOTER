extends CharacterBody3D

@export var speed: float = 5.0
@export var chase_speed: float = 0.05
@export var detection_range: float = 15.0
@export var health: int = 100
@export var detection:ShapeCast3D
@onready var player = get_tree().get_root().get_node("World/Player/CharacterBody3D")
@export var collision:CollisionShape3D
@export var ANIMATE:AnimationPlayer


func _ready() -> void:
	Global.enemy=self
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _process(delta:float)->void:
	Global.debug._add_debug_property("POSITIONS",position.x,6)
	Global.debug._add_debug_property("PLAYER_POSITION",Global.player.global_position.x,7)
	Global.debug._add_debug_property("HEALTH",health,8)
	

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	if is_node_detected(detection,player)[0]:
		chase()
	
	
	#CharacterBody3D:<CharacterBody3D#43654317562>
	move_and_slide()

func chase():
	if position.x<Global.player.global_position.x:
		position.x+=chase_speed
	elif position.x>Global.player.global_position.x:
		position.x-=chase_speed
	if position.z<Global.player.global_position.z:
		position.z+=chase_speed
	elif position.z>Global.player.global_position.z:
		position.z-=chase_speed
	
# Returns a tuple: (detected: bool, index: int)
func is_node_detected(shape_cast: ShapeCast3D, target_node: Node) -> Array:
	if shape_cast.is_colliding():
		var collision_count = shape_cast.get_collision_count()
		for i in range(collision_count):
			var collider = shape_cast.get_collider(i)
			if collider == target_node:
				return [true, i]  # Node detected, return index
	return [false, -1]  # Node not detected

func On_hit():
	health-=10
	if health<=0:
		queue_free()
	
	
	
	#if not player:
		#return
#
	#var distance_to_player = global_position.distance_to(player.global_position)
#
	#if distance_to_player <= detection_range:
		#chase_player(delta)
	#else:
		#idle_patrol(delta)
#
#func idle_patrol(delta: float) -> void:
	## Example: do nothing for now
	#velocity = Vector3.ZERO
	#move_and_slide()
#
#func chase_player(delta: float) -> void:
	#var direction = (player.global_position - global_position).normalized()
	#velocity = direction * chase_speed
	#move_and_slide()
#
#func take_damage(amount: int) -> void:
	#health -= amount
	#if health <= 0:
		#die()
#
#func die() -> void:
	#queue_free()
