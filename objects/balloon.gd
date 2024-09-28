extends KinematicBody2D

var speed = Vector2(0,0)
var max_speed = 500

var move_left = false
var move_right = false
var count_money = 0
var rotate_t = 0
var invisible = false
var skeeper = false
var sk_state = 0

onready var global = get_node('/root/global')
onready var sound = global.load_settings().sound

func _ready():
	$skin_anime.play('s'+str(global.load_skin_select()))

func _physics_process(delta):
	if skeeper:
		if sk_state==0:
			get_node('../').world_speed += (50-get_node('../').world_speed)/20
			if get_node('../').countObstacles >= 20:
				sk_state=1
				$anime.play('waiting')
				get_node('../camera_parent/camera/anim').play('normal')
		if sk_state==1:
			get_node('../').world_speed += (5-get_node('../').world_speed)/20
			if get_node('../').countObstacles >= 22:
				$anime.play('normal')
				sk_state = 0
				skeeper = false
		
	if position.x > 640-62.5:
		position.x = 640-62.5
	if position.x < 0+62.5:
		position.x = 0+62.5
		
	if move_right:
		speed.x += 50
		if speed.x > max_speed:
			speed.x = max_speed
		rotate_t = -20
	elif move_left:
		speed.x -= 50
		if speed.x < -max_speed:
			speed.x = -max_speed
		rotate_t = 20
	else:
		speed.x -= (speed.x)/10
		
	move_and_slide(speed*(delta+1))
		
	if position.x > 640-62.5:
		rotate_t = -5
	if position.x < 0+62.5:
		rotate_t = 5
		
	if not move_right and not move_left:
		rotate_t = 0
	
	rotation_degrees -= (rotate_t+rotation_degrees)/20
	
func get_money(count_money):
	self.count_money += count_money
	print(self.count_money)
	get_node('../main_GUI').add_money(count_money)
	if sound==1:
		get_node('../coin_audio').play()
	
func death():
	if not visible and not skeeper:
		get_node('../').game_over()
		position.y = -3000
		if sound==1:
			get_node('../gameover_audio').play()		
func start_skeeper():
	skeeper = true
	get_node('../camera_parent/camera/anim').play('shake_your_tale_s')
func start_visible():
	invisible = true
	$invisible_false.play('invis_false')
func finish_visible():
	invisible = false
	$invisible_false.play('invis_true')
		