extends Node2D

var world_speed = 3
onready var gl = get_node('/root/global')
func _ready():
	$animation.play('show')
	if global.challenge_mode:
		$SCORE.text = "SCORE: "+str(gl.score)+"/"+str(global.challenge_goal)
	else:
		$SCORE.text = "SCORE: "+str(gl.score)
	$BEST.text = "BEST: "+str(gl.get_best())
	gl.send_best_score_to_game_center(gl.get_best())
	pass

func _physics_process(delta):
	world_speed-=(world_speed)/5


func _on_TouchScreenButton_released():
	if global.challenge_mode:
		get_tree().change_scene("res://scenes/chalenges_scene.tscn")
	else:
		get_tree().change_scene("res://scenes/menu_scene.tscn")
	$TouchScreenButton/anim.play_backwards('press')


func _on_Button_button_up():
	global.save_daily(global.load_daily()-500)
	$Node2D2.startsec = global.load_daily()
	$Node2D2.updatesec()


func _on_TouchScreenButton_pressed():
	$TouchScreenButton/anim.play('press')
