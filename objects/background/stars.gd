extends Node2D

func _physics_process(delta):
	var speed = get_node('../').world_speed
	get_node('stars'+str(1)).position.y-=speed/3
	get_node('stars'+str(2)).position.y-=speed/3
	if get_node('stars'+str(1)).position.y <= -1136:
		get_node('stars'+str(1)).position.y = 1136
	if get_node('stars'+str(2)).position.y <= -1136:
		get_node('stars'+str(2)).position.y = 1136
