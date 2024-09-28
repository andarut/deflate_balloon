extends Node2D

var count = 8

var savedcount = 0

var start_p = Vector2(0,0)
var current_p = Vector2(0,0)
var cc_p = 0.0
var end_p = Vector2(0,0)

var start_pos = 0.0

var isScrolling = false

var speed_stop = 0.0
var pspeed_stop = 0.0

var maxscroll = 600

func _ready():
	pass

func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			start_pos = $scroll.position.y
			start_p = get_global_mouse_position()
			isScrolling = true
			print("START P: ", start_p)
		else:
			end_p = get_global_mouse_position()
			speed_stop = cc_p-end_p.y
			isScrolling = false
			print("END P: ", end_p)
		if isScrolling:
			speed_stop = (current_p.y - get_global_mouse_position().y)*-20
			
func _physics_process(delta):
	if isScrolling:
		current_p = get_global_mouse_position()
		$scroll.position.y = start_pos-(start_p.y-current_p.y)
		print("CURRENT P: ", start_p)
		if $scroll.position.y > 0:
			$scroll.position.y -= $scroll.position.y/1.4
		if $scroll.position.y < -maxscroll:
			$scroll.position.y += (-maxscroll-$scroll.position.y)/1.4
	else:
		if speed_stop!= 0:
			if $scroll.position.y > 0:
				$scroll.position.y -= $scroll.position.y/10
				speed_stop = 0
			if $scroll.position.y < -maxscroll:
				$scroll.position.y += (-maxscroll-$scroll.position.y)/10
				speed_stop = 0
		else:
			if $scroll.position.y > 0:
				$scroll.position.y -= $scroll.position.y/10
			if $scroll.position.y < -maxscroll:
				$scroll.position.y += (-maxscroll-$scroll.position.y)/10
		
		if speed_stop > 3:
			$scroll.position.y -= speed_stop
			speed_stop -= 4
		elif speed_stop < -3:
			$scroll.position.y -= speed_stop
			speed_stop += 4
		else:
			speed_stop = 0

func _on_Timer_timeout():
	cc_p = current_p.y
