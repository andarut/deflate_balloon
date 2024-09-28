extends CanvasLayer

var world_speed = 3

onready var global = get_node('/root/global')
var opened = 1
var lvl = 1

onready var gl = get_node('/root/global')
func _ready():
	opened = global.load_ch().count
	lvl = global.load_ch().lvl
	if global.challenge_completed:
		if global.ch_lvl == opened:
			opened+=1
		global.challenge_completed = false
	$animation.play('show')
	for i in range(1,11):
		get_node('challenge_btn'+str(i)+'/Caption').text = str(i)
		get_node('challenge_btn'+str(i)).lvl = i
		get_node('challenge_btn'+str(i)).goal = 5*lvl*lvl*i
		if i <= opened:
			get_node('challenge_btn'+str(i)).active()
	$lvl.text = "LEVEL "+str(lvl)
	global.save_ch(opened, lvl)
	if opened >= 11:
		$gift_button/anim.play('unlock')


func _on_TouchScreenButton_released():
	get_tree().change_scene("res://scenes/menu_scene.tscn")


func _on_start_ch_timer_timeout():
	get_tree().change_scene("res://scenes/game_scene.tscn")


func _on_gift_button_released():
	if opened >= 11:
		global.gift_count = 2000*lvl*lvl
		get_tree().change_scene("res://scenes/gift_screen.tscn")
