extends Node2D

var active = false
var is_left = false

func _ready():
	start_right()

func start_left():
	$animation.play('wind')
	$slow_animation.play('wind')
	is_left = true
	
func start_right():
	$animation.play_backwards('wind')
	$slow_animation.play_backwards('wind')
	is_left = false
	
func _physics_process(delta):
	if active:
		$collision_area.position.y = 0
	else:
		$collision_area.position.y = -1000
	
	

func _on_collision_area_body_entered(body):
	if body.has_method("death"):
		if is_left:
			body.move_left = true
		else:
			body.move_right = true


func _on_collision_area_body_exited(body):
	if body.has_method("death"):
		body.move_left = false
		body.move_right = false
