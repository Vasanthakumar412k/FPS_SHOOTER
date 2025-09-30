extends CenterContainer 
@export var top:Line2D
@export var right:Line2D
@export var bottom:Line2D
@export var left:Line2D
@export var RETICLE_DISTANCE:float=2.5
@export var RETICLE_SPEED:float=0.25
@export var PLAYER_CONTROLLER:CharacterBody3D

@export var DOT_RADIUS:float =1.0
@export var DOT_COLOR:Color=Color.RED

# Called when the node enters the scene tree for the first time.
func _ready():
	
	queue_redraw()
	visible=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	adjust_reticle_lines()
func _draw():
	draw_circle(Vector2(0,0),DOT_RADIUS,DOT_COLOR)
	
func adjust_reticle_lines():
	var speed=Global.player.velocity.length()
	var origin=Vector3.ZERO
	var pos=Vector2.ZERO

	top.position=lerp(top.position,pos+Vector2(0,-speed*RETICLE_DISTANCE),RETICLE_SPEED)
	right.position=lerp(right.position,pos+Vector2(speed*RETICLE_DISTANCE,0),RETICLE_SPEED)
	bottom.position=lerp(bottom.position,pos+Vector2(0,speed*RETICLE_DISTANCE),RETICLE_SPEED)
	left.position=lerp(left.position,pos+Vector2(-speed*RETICLE_DISTANCE,0),RETICLE_SPEED)
