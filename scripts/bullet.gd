extends Node3D

@export var area: ShapeCast3D
@export var sparks: GPUParticles3D
@export var bullet: MeshInstance3D
@export var light: OmniLight3D
@export var speed: float = 2000.0  # units per second

func _ready() -> void:
	sparks.visible = false
	area.enabled = true  # Make sure ShapeCast3D is active

	# Automatically delete after 10 seconds
	free_after_delay(10.0)

func _process(delta: float) -> void:
	if not area.is_colliding():
		# Move bullet forward along its local Z axis
		global_translate(transform.basis.z * speed * delta)
	else:
		# Collision detected
		on_hit()

# Handle collision effects
func on_hit() -> void:
	# Stop moving the bullet
	set_process(false)

	# Show effects
	bullet.visible = false
	sparks.visible = true
	light.omni_range = 10

	# Free after 1 second (explosion time)
	free_after_delay(1.0)

# Delete bullet after delay
func free_after_delay(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	if is_inside_tree():
		queue_free()
