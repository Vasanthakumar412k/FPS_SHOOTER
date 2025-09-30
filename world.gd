extends Node3D

var raycast_test=preload("res://ray_cast_test.tscn")
@export var ANIMATION:AnimationPlayer
@export var decals:MeshInstance3D

func _ready():
	light.rotation.x-=170
	Global.world=self
	ANIMATION.play("lift working")
	print(rad_to_deg(light.rotation.x))
	print(rad_to_deg(light.rotation.y))
	print(rad_to_deg(light.rotation.z))
	
	
var new_position=Vector3(10,40,10)
	
#func make_decals(position):
#	decals.position=position  
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
@export var rotation_speed: float = 1.0 # degrees per second
@export var light:DirectionalLight3D
func _process(delta):
	if light.rotation.x<=0:
		light.rotate_z(deg_to_rad(rotation_speed*delta))
		light.visible=true
	elif light.rotation.x>=0:
		light.rotate_z(deg_to_rad(rotation_speed*delta))
		light.visible=false
	
