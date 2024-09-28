extends Node2D

var cs = false

func _physics_process(delta):
	var speed = get_node('../').world_speed
	position.y -= speed
	if position.y <= -1936:
		queue_free()
	if position.y <= 0 and not cs:
		cs = true
		get_node('../').create_new_area()


func _on_area_body_entered(body):
	if body.has_method("death"):
		get_node('../').world_speed = 0
		get_node('../main_GUI').challenge_complete()
