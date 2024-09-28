extends TouchScreenButton

var goal = 5
var active = false
var lvl = 0

onready var global = get_node('/root/global')


func _on_challenge_btn_released():
	if active:
		get_node('../animation').play_backwards('show')
		global.challenge_mode = true
		global.challenge_goal = goal
		global.ch_lvl = lvl
		get_node('../start_ch_timer').start()
		
func active():
	active = true
	$anim.play('active')
