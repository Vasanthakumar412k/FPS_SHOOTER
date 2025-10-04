extends PanelContainer

@onready var debug_container=%VBoxContainer

var frames_per_second:=0

func _ready():
	visible=false
	Global.debug=self
	
func _input(event):
	if event.is_action_pressed("debug"):
		visible=!visible
		
func _process(delta):
	frames_per_second=1.0/delta
	_add_debug_property("fps",frames_per_second,1)
	
func _add_debug_property(title, value, order):
	var target = debug_container.find_child(title, true, false)
	if target == null:
		target = Label.new()
		target.name = title
		target.text = title + ": " + str(value)
		debug_container.add_child(target)
	else:
		target.text = title + ": " + str(value)
	order = clamp(order, 0, debug_container.get_child_count() - 1)
	debug_container.move_child(target, order)
