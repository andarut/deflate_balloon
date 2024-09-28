extends CanvasLayer

onready var global = get_node('/root/global')

var old_score = 0
var score = 0

var best_score = 0

var money = 0

var smalled = false

var showedspeed = false

func _ready():
	global.chit_money()
	$animation.play('start')
	best_score = int(global.get_best())
	$best.text = str(best_score)
	money = int(global.get_money())
	$coins2.text = str(money)
	$touch_icon/touch/touch_anim.play('t')
	if not global.challenge_mode:
		$score.text = "0"
	else:
		$score.text = "0/"+str(global.challenge_goal)
		$score/anim.play('small')
	if global.load_help()==1:
		$skeeper_btn/anime.play('show')
		showedspeed = true
		if int(global.get_money())<2000:
			$skeeper_btn/dis_anim.play('dis')
		if int(global.get_money())<5000:
			$invisible_btn/dis_anim.play('dis')	
			

func set_score(score):
	if best_score <= score:
		best_score = score
		$best_anim.play('new_best')
		global.save_best(score)
	self.score = score
	if not get_node("../").challenge_mode:
		$score.text = str(score)
		if score > 99 and not smalled:
			$score/anim.play('small')
			smalled = true
	else:
		$score.text = str(score)+"/"+str(get_node("../").challenge_goal)
	$best.text = str(best_score)
	if old_score != score:
		$obj_anim.play('add_score')
		global.score = score
	old_score = score
	print(showedspeed)
	if score==1 && not get_node('../balloon').skeeper && showedspeed:
		$skeeper_btn/anime.play_backwards('show')
		$Show_visible.visible = 1
	if score==10:
		$"RUNER 1/anime".play('show')
		$"RUNER 1/Timer".start()	
	if score==100:
		$"RUNER 1/bestScore3".texture = $"RUNER 1/bestScore2".texture
		$"RUNER 1/anime".play('show')
		$"RUNER 1/Timer".start()
		$"RUNER 1/Label2".text = "RUN 100 AREAS"
	if score==1000:
		$"RUNER 1/bestScore4".texture = $"RUNER 1/bestScore2".texture
		$"RUNER 1/anime".play('show')
		$"RUNER 1/Timer".start()
		$"RUNER 1/Label2".text = "RUN 1000 AREAS"
	if money==10:
		$"RICH 1/anime".play('show')
		$"RICH 1/Timer1".start()
	if money==100:
		$"RICH 1/bestScore2".texture = $"RICH 1/bestScore".texture
		$"RICH 1/anime".play('show')
		$"RICH 1/Timer1".start()
		$"RICH 1/Label2".text = "COLLECT 100 COINS"
	if money==1000:
		$"RICH 1/bestScore3".texture = $"RICH 1/bestScore".texture
		$"RICH 1/anime".play('show')
		$"RICH 1/Timer1".start()
		$"RICH 1/Label2".text = "COLLECT 1000 COINS"
		
	
	
func game_over():
	$animation.play("close")
	$close_timer.start()


func _on_close_timer_timeout():
	get_tree().change_scene("res://scenes/looser_scene.tscn")
	
func add_money(count):
	$coin_anim.play('add')
	money += 1
	$coins2.text = str(money)
	global.save_money(money)
	
func challenge_complete():
	$ch_complete/anim.play('complete')
	$animation.play('close')
	$ch_close_timer.start()
	global.challenge_completed = true

func _on_ch_close_timer_timeout():
	get_tree().change_scene("res://scenes/chalenges_scene.tscn")


func _on_skeeper_btn_released():
	if int(global.get_money())>=2000:
		$skeeper_btn.visible = 0
		get_node('../balloon').start_skeeper()
		global.save_money(int(global.get_money())-2000)
		money = int(global.get_money())


func _on_invisible_btn_released():
	if int(global.get_money())>=5000:
		$Show_visible.visible = 1
		$invisible_btn/anime.play_backwards('show')
		get_node('../balloon').start_visible()
		global.save_money(int(global.get_money())-5000)
		money = int(global.get_money())
		$Visible_timer.start()
		$Show_visible.visible = 0
		$invisible_btn/Timer34.stop()


func _on_Show_visible_released():
	$Show_visible.visible = 0
	$skeeper_btn.position.y = -2000
	$invisible_btn/anime.play('show')
	$invisible_btn/Timer34.start()
	
func _on_Visible_timer_timeout():
	get_node('../balloon').finish_visible()


func _on_Timer_timeout():
	$"RUNER 1/anime".play_backwards('show')
	$"RUNER 1/Timer".stop()


func _on_Timer1_timeout():
	$"RICH 1/anime".play_backwards('show')
	$"RICH 1/Timer1".stop()


func _on_Timer34_timeout():
	$invisible_btn/anime.play_backwards('show')
	$Show_visible.visible = 1
	$invisible_btn/Timer34.stop()
