extends MeshInstance3D
var active_bullet_instances := []

var result={}
var raycast_test=preload("res://scenes/ray_cast_test.tscn")
var sphere=preload("res://scenes/sphere.tscn")
@export var bullet_mesh:MeshInstance3D
@export var blast:MeshInstance3D
var a=0
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ATTACK=self
	var mesh = self.mesh
	var ray_collision=null

	if mesh == null or mesh.get_surface_count()==0:
		return

	for i in range(mesh.get_surface_count()):
		var mat = StandardMaterial3D.new()
		mat.albedo_color = Color(0.1, 0.1, 0.1)  # Gun-metal grey
		mat.metallic = 1.0
		mat.roughness = 0.3
		mat.specular = 0.5
		mesh.surface_set_material(i, mat)

	 # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _attack():
	var camera=Global.player.CAMERA_CONTROLLER
	var space_state=camera.get_world_3d().direct_space_state
	var screen_center=get_viewport().size/2
	var origin=camera.project_ray_origin(screen_center)
	var end=origin+camera.project_ray_normal(screen_center)*1000
	var query=PhysicsRayQueryParameters3D.create(origin,end)
	query.collide_with_bodies=true
	var result=space_state.intersect_ray(query)
	if result =={}:
		_test_raycast(bullet_mesh.global_transform.origin,Vector3(0,0,100))
	elif result:
		var hit_node = result.collider
		if hit_node.has_method("On_hit"):
			hit_node.On_hit()
			_test_raycast(bullet_mesh.global_transform.origin, result.position)
		else:
			_test_raycast(bullet_mesh.global_transform.origin, Vector3(0,0,100))

	
#	Global.debug._add_debug_property("collision:",result,3)
#	if result=={}:
#		pass
#	else:
#		Global.world.make_decals(result.position)
var count=0
func count_bullets():
	count+=1

func _process(delta):
	Global.debug._add_debug_property("bricks",count,4)
	#for bullet in active_bullet_instances:
		#if bullet:  # make sure it hasn’t been freed
			#print(active_bullet_instances)
			#

const SPEED := 20.0  # units per second
var okay=true

func _test_raycast(position: Vector3, end: Vector3) -> void:
	var instance = raycast_test.instantiate()
	
	
	instance.transform.basis = bullet_mesh.global_transform.basis
	get_tree().root.add_child(instance)
	
	instance.global_position = position
	
	#var sphere_instance = sphere.instantiate()
	#get_tree().root.add_child(sphere_instance)
	#sphere_instance.global_position = end
	# store it for tracking
	active_bullet_instances.append(instance)
	count_bullets()
	#blast.visible=true
	#await get_tree().create_timer(0.07).timeout
	#blast.visible=false

#func _test_raycast(position: Vector3,end) -> void:
	#var instance = raycast_test.instantiate()
	#instance.transform.basis=bullet_mesh.global_transform.basis
	#get_tree().root.add_child(instance)
	#instance.global_position = position
	#track_position(instance.global_position)
	#blast.visible=true
	#await get_tree().create_timer(0.07).timeout
	#blast.visible=false
	#count_bricks()
