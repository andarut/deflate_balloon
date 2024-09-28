extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var cs = false
func _ready():
	$Node2D2/Node2D/laser/animation.play('animation')
	$Node2D/Node2D/laser/animation.play('animation')
	
func _physics_process(delta):
	var speed = get_node('../').world_speed
	position.y -= speed
	if position.y <= -1936:
		queue_free()
	if position.y <= 0 and not cs:
		cs = true
		get_node('../').create_new_area()
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
