extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var cs = false
func _ready():
	pass
	
func _physics_process(delta):
	var speed = get_node('../').world_speed
	position.y -= speed
	if position.y <= -1936:
		queue_free()
	if position.y <= 0 and not cs:
		cs = true
		get_node('../').create_new_area()
