extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var global = get_node('/root/global')

func _ready():
	$animation.play('start')

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_play_btn_released():
	global.challenge_mode = false
	global.challenge_goal = 0
	$play_btn/anim.play_backwards('press')
	$animation.play_backwards('start')
	$play_timer.start()
	


func _on_play_timer_timeout():
	get_tree().change_scene("res://scenes/game_scene.tscn")


func _on_ch_timer_timeout():
	get_tree().change_scene("res://scenes/chalenges_scene.tscn")


func _on_TouchScreenButton_released():
	$ch/anim.play_backwards('press')
	$animation.play_backwards('start')
	$ch_timer.start()




func _on_settings_released():
	get_tree().change_scene("res://scenes/settings_scene.tscn")


func _on_play_btn_pressed():
	$play_btn/anim.play('press')


func _on_ch_pressed():
	$ch/anim.play('press')


func _on_touch_pressed():
	$shop/anim.play('press')


func _on_touch_released():
	$shop/anim.play_backwards('press')
	$animation.play_backwards('start')
	$sh_timer.start()


func _on_sh_timer_timeout():
	get_tree().change_scene("res://scenes/shop_scene.tscn")


func _on_scorebtn_released():
	global.open_game_center()
	$scorebtn/anim.play_backwards('press')


func _on_scorebtn_pressed():
	$scorebtn/anim.play('press')
