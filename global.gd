extends Node

var fs = File.new()
var lang_file_path = "res://langs.json"
var userbest_file_path = "user://best_score.cutie"
var usermoney_file_path = "user://money.cutie"
var ch_file_path = "user://challenges.cutie"
var skins_file_path = "user://skins.cutie"
var skinscount_file_path = "user://skins_count.cutie"
var skinsselect_file_path = "user://selected_skin.cutie"
var help_file_path = "user://help.cutie"
var daily_path = "user://daily.cutie"
var settings_file_path = "user://settings.cutie"
var money = int(get_money())

var score = 0

var language = 0
var lang_json = parse_json('{}')

var challenge_mode = true
var challenge_goal = 0
var challenge_completed = false

var ch_lvl = 0

var gift_count = 0

var world_speed = 3

var GameCenter = null

func _ready():
	
	if Engine.has_singleton("GameCenter"):
        GameCenter = Engine.get_singleton("GameCenter")
	pass
	
func open_game_center():
	if Engine.has_singleton("GameCenter"):
		GameCenter.show_game_center( { "view": "leaderboards", "leaderboard_name": "thedeflatehighscore" } )
	
func send_best_score_to_game_center(bestscore):
	if GameCenter!=null:
		var bs = int(bestscore)
		GameCenter.post_score( { "score": bs, "category": "thedeflatehighscore" } )
	print({ "score": int(bestscore), "category": "thedeflatehighscore", })

func save_settings(sound, vibration, noads):
	fs.open(settings_file_path, File.WRITE)
	fs.store_string(str('{"sound" : '+str(sound)+', "vibration" :'+str(vibration)+', "noads" : '+str(noads)+" }"))
	fs.close()
	
func load_settings():
	fs.open(settings_file_path, File.READ)
	if fs.get_as_text()=='':
		return parse_json('{"sound" : 1, "vibration" : 1, "lvl" : 0 }')
	var ch_json = parse_json(fs.get_as_text())
	fs.close()
	return ch_json

func save_daily(id):
	fs.open(daily_path, File.WRITE)
	fs.store_string(str(id))
	print('SAVED START SEC DATA: ', str(id))
	fs.close()
	
func load_daily():
	fs.open(daily_path, File.READ)
	var return_value = fs.get_as_text()
	if return_value == '':
		return 0
	return int(return_value)

func save_help(id):
	fs.open(help_file_path, File.WRITE)
	fs.store_string(str(id))
	print('SAVED SELECT SKINS DATA: ', str(id))
	fs.close()
	
func load_help():
	fs.open(help_file_path, File.READ)
	var return_value = fs.get_as_text()
	if return_value == '':
		return 0
	return int(return_value)


func save_skin_select(id):
	fs.open(skinsselect_file_path, File.WRITE)
	fs.store_string(str(id))
	print('SAVED SELECT SKINS DATA: ', str(id))
	fs.close()
	
func load_skin_select():
	fs.open(skinsselect_file_path, File.READ)
	var return_value = fs.get_as_text()
	if return_value == '':
		return 0
	return int(return_value)

func save_skincount(count):
	fs.open(skinscount_file_path, File.WRITE)
	fs.store_string(str(count))
	print('SAVED COUNT SKINS DATA: ', str(count))
	fs.close()
	
func load_skincount():
	fs.open(skinscount_file_path, File.READ)
	var return_value = fs.get_as_text()
	if return_value == '':
		return 0
	return int(return_value)

func save_skins(data):
	fs.open(skins_file_path, File.WRITE)
	fs.store_string(str(data))
	fs.close()

func load_skins():
	fs.open(skins_file_path, File.READ)
	var s_json = parse_json(fs.get_as_text())
	fs.close()
	return s_json
	
	

func save_ch(ch, ch_lvl):
	fs.open(ch_file_path, File.WRITE)
	fs.store_string(str('{"count" : '+str(ch)+', "lvl" : '+str(ch_lvl)+" }"))
	fs.close()
	
func load_ch():
	fs.open(ch_file_path, File.READ)
	if fs.get_as_text()=='':
		return parse_json('{"count" : 1, "lvl" : 1 }')
	var ch_json = parse_json(fs.get_as_text())
	fs.close()
	return ch_json

func save_best(best):
	fs.open(userbest_file_path, File.WRITE)
	fs.store_string(str(best))
	fs.close()
	
func get_best():
	fs.open(userbest_file_path, File.READ)
	var b = fs.get_as_text()
	if b!='':
		var be = b
		fs.close()
		return be
	else:
		fs.close()
		return 0
		
func save_money(best):
	fs.open(usermoney_file_path, File.WRITE)
	fs.store_string(str(best))
	fs.close()
	
func get_money():
	fs.open(usermoney_file_path, File.READ)
	var b = fs.get_as_text()
	if b!='':
		var be = b
		fs.close()
		return be
	else:
		fs.close()
		return 0


func chit_money():
	money+=10000
	global.save_money(money)	
func chit_score():
	score+=10000
	global.save_score(score)
		
func lang():
	fs.open(lang_file_path, File.READ)
	if language == 1:
		lang_json = parse_json(fs.get_as_text()).RU_ru
	else:
		lang_json = parse_json(fs.get_as_text()).US_en
	fs.close()
	return lang_json