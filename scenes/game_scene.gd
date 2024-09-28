extends Node2D

onready var global = get_node('/root/global')
onready var sound = global.load_settings().sound

var world_speed = 5.0
var difficulty = 0
var countObstacles = 0
#Загрузка зон
const a1_1 = preload("res://objects/areas/area1_1.tscn")
const a2_1 = preload("res://objects/areas/area2_1.tscn")
const a2_2 = preload("res://objects/areas/area2_2.tscn")
const a2_3 = preload("res://objects/areas/area2_3.tscn")
const a2_4 = preload("res://objects/areas/area2_4.tscn")
const a2_5 = preload("res://objects/areas/area2_5.tscn")
const a2_6 = preload("res://objects/areas/area2_6.tscn")
const a2_7 = preload("res://objects/areas/area2_7.tscn")
const a3_1 = preload("res://objects/areas/area3_1.tscn")
const a3_2 = preload("res://objects/areas/area3_2.tscn")
const a3_3 = preload("res://objects/areas/area3_3.tscn")
const a3_4 = preload("res://objects/areas/area3_4.tscn")
const a4_1 = preload("res://objects/areas/area4_1.tscn")
const a4_2 = preload("res://objects/areas/area4_2.tscn")

#Массив финальной зоны для испытаний
const end_island = preload("res://objects/areas/challenge_end.tscn")

#Массивы для каждой сложности
var areas1 = [a1_1, a2_1]
var areas2 = [a2_7, a2_7, a2_7, a2_5, a2_7]
var areas3 = [a2_7, a2_2, a2_7, a2_6]
var areas4 = [a2_2, a2_6, a2_1, a2_5, a2_3, a1_1]

var score = 0

var is_over = false

var challenge_mode = true
var challenge_goal = 5

var lvl_step = 0
var help_state = 0
var saved_speed = 0

func _ready():
	$fon_audio.play()
	if global.load_help()==1:
		lvl_step=1
	else:
		$help_timer.start()
	challenge_mode = global.challenge_mode
	challenge_goal = global.challenge_goal

func _input(event):
	if event is InputEventScreenTouch && lvl_step >= 1:
		if event.is_pressed():
			if get_global_mouse_position().x > 320:
				$wind.start_left()
			else:
				$wind.start_right()
			$wind/alpha_animation.play('show')
			$wind.active = true
			if help_state == 1:
				if get_global_mouse_position().x > 320:
					help_state = 0
					$main_GUI/help_anim.play_backwards('right')
					world_speed = saved_speed
					$wind.start_left()
		else:
			$wind/alpha_animation.play_backwards('show')
			$wind.active = false

func create(obj):
	var new_area = obj.instance()
	if int(rand_range(0,2))==1:
		new_area.position = Vector2(0, 1136)
	else:
		new_area.position = Vector2(640, 1136)
		new_area.scale.x = -1
	add_child(new_area)	

func add_score():
	score+=1
	if sound==1:
		$score_audio.play()
	$main_GUI.set_score(score)

func create_new_area():
	print(world_speed)
	print('CREATE NEW AREA')
	countObstacles += 1
	if not is_over:
		$main_GUI.set_score(score)
	if challenge_mode:
		if score >= challenge_goal:
			create(end_island)
			return
	print('Ok1')
	if countObstacles < 3:
		create(areas1[int(rand_range(0,2))])
		return
	if countObstacles < 6:
		create(areas2[int(rand_range(0,5))])
		return
	if countObstacles < 16:
		create(areas3[int(rand_range(0,4))])
		return
	if world_speed<21:
		create(areas4[int(rand_range(0,6))])
		return
	world_speed+=0.05
	create(areas4[int(rand_range(0,6))])
	
func game_over():
	print('3:')
	$camera_parent/camera/anim.play('shake_your_tale')
	is_over = true
	$main_GUI.game_over()
	
func _physics_process(delta):
	if is_over:
		world_speed -= world_speed/45
		print(world_speed)
	if help_state == 1:
		world_speed = 0;
	


func _on_help_timer_timeout():
	saved_speed = world_speed
	help_state = 1
	$main_GUI/help_anim.play('right')
	lvl_step += 1
	global.save_help(1)


func _on_scoretimer_timeout():
	if not lvl_step==0 and not is_over:
		add_score()
