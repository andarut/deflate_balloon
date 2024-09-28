extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var cs = false
func _ready():
	$pinion1/animation1.play('pinion1')
	$pinion2/animation2.play('pinion2')
	$pinion3/animation3.play('pinion3')
	
func _physics_process(delta):
	var speed = get_node('../').world_speed
	position.y -= speed
	if position.y <= -1936:
		queue_free()
		print('REMOVED OLD AREA')
	if position.y <= 0 and not cs:
		cs = true
		get_node('../').create_new_area()
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
