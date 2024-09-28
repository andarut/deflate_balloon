extends Node2D

onready var global = get_node('/root/global')

var getting = false
var enable = true

var waiting = false

var old = 10
var add = 100

var sec = 86400

var startsec = 0
var startyear = 0

func _ready():
	$daily/anime.play('active')
	old = int(global.get_money())
	startsec = global.load_daily()
	updatesec()
	if sec <= 0:
		enable = true
		waiting = false
		sec = 0
	else:
		enable = false
		waiting = true
		$daily/anime.play('disable')
	pass
	
func updatesec():
	var time = OS.get_time();
	var date = OS.get_date();
	var cy = date.year
	var cm = date.month
	var cd = date.day
	var ch = time.hour
	var cmin = time.minute
	var cs = time.second
	
	var csec = 0
	csec += cs
	csec += cmin*60
	csec += ch*(60*60)
	csec += (cd-1)*24*(60*60)
	if cm > 1:
		csec += 31*24*(60*60)
	if cm > 2 and cy%4==0:
		csec += 29*24*(60*60)
	if cm > 2 and cy%4!=0:
		csec += 28*24*(60*60)
	if cm > 3:
		csec += 31*24*(60*60)
	if cm > 4:
		csec += 30*24*(60*60)
	if cm > 5:
		csec += 31*24*(60*60)
	if cm > 6:
		csec += 30*24*(60*60)
	if cm > 7:
		csec += 31*24*(60*60)
	if cm > 8:
		csec += 31*24*(60*60)
	if cm > 9:
		csec += 30*24*(60*60)
	if cm > 10:
		csec += 31*24*(60*60)
	if cm > 11:
		csec += 30*24*(60*60)
		
	print("START SEC", startsec)
	print("CURRENT SEC", csec)
	print("TIME COMPLETED", csec-startsec)
	
	sec = 86400 - (csec - startsec)
	
	
func setstartsec():
	var time = OS.get_time();
	var date = OS.get_date();
	
	var cy = date.year
	var cm = date.month
	var cd = date.day
	var ch = time.hour
	var cmin = time.minute
	var cs = time.second
	
	var csec = 0
	csec += cs
	csec += cmin*60
	csec += ch*(60*60)
	csec += (cd-1)*24*(60*60)
	if cm > 1:
		csec += 31*24*(60*60)
	if cm > 2 and cy%4==0:
		csec += 29*24*(60*60)
	if cm > 2 and cy%4!=0:
		csec += 28*24*(60*60)
	if cm > 3:
		csec += 31*24*(60*60)
	if cm > 4:
		csec += 30*24*(60*60)
	if cm > 5:
		csec += 31*24*(60*60)
	if cm > 6:
		csec += 30*24*(60*60)
	if cm > 7:
		csec += 31*24*(60*60)
	if cm > 8:
		csec += 31*24*(60*60)
	if cm > 9:
		csec += 30*24*(60*60)
	if cm > 10:
		csec += 31*24*(60*60)
	if cm > 11:
		csec += 30*24*(60*60)
		
	startsec = csec
		
	print("SET GETTED SECOND", csec)

func _physics_process(delta):
	if getting:
		$daily/gettinglbl.text = str(old)+"+"+str(add)
	if not waiting:
		$daily/Label.text = "Daily bonus"
	else:
		var h = sec/3600
		var m = (sec/60)%60
		var s = sec%60
		$daily/Label.text = str(h)+"h "+str(m)+"m "+str(s)+"s"


func _on_TouchScreenButton_released():
	if enable and not getting:
		$daily/pres_anim.play_backwards('press')
		print('DAILY BOUNS BUTTON ACTIVATED')
		$daily/anime.play('getting')
		$Timer2.start()
		$daily/gettinglbl.text = str(old)+"+"+str(add)
		global.save_money(old+add)
		setstartsec()
		global.save_daily(startsec)
		enable = false


func _on_TouchScreenButton_pressed():
	if enable and not getting:
		$daily/pres_anim.play('press')


func _on_Timer_timeout():
	if getting:
		if add > 0:
			add-=1
			old+=1
		else:
			$distimer.start()
			getting = false


func _on_Timer2_timeout():
	getting = true


func _on_distimer_timeout():
	sec = 86400
	enable = false
	waiting = true
	$daily/danime.play('disable')
	$daily/anime.play_backwards('getting')


func _on_sec_timer_timeout():
	if sec>0:
		sec-=1
		print(sec)


func _on_updatetime_timeout():
	if waiting:
		updatesec()
