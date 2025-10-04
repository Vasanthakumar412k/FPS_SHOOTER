class_name PlayerMovement
extends State

var PLAYER: Player
var ANIMATION: AnimationPlayer


func _ready() -> void:
	await owner.ready
	var child = owner.get_child(0)
	await child
	PLAYER = child as Player
	ANIMATION=PLAYER.ANIM


	
	
