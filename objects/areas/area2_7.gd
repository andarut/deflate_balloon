extends Node2D

var cs = false

func _ready():
	pass
	$thorns.position.x = rand_range(0,20)

func _physics_process(delta):
	var speed = get_node('../').world_speed
	position.y -= speed
	if position.y <= -1936:
		queue_free()
		print('REMOVED OLD AREA')
	if position.y <= 0 and not cs:
		cs = true
		get_node('../').create_new_area()
		print('CREATE SIGNAL')
