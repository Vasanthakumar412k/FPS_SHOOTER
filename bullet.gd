extends Node3D

@export var area:ShapeCast3D
@export var sparks:GPUParticles3D
@export var bullet:MeshInstance3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sparks.visible=false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !area.is_colliding():
		position+=transform.basis*Vector3(0,0,20)
	elif area.is_colliding():
		bullet.visible=false
		sparks.visible=true
		await get_tree().create_timer(1).timeout
		queue_free()  
		
	
	
	
	
	
