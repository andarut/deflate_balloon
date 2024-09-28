extends Node2D

onready var gl = get_node('/root/global')

func _ready():
	load_language()
	$anim.play('show')
	sound = global.load_settings().sound
	vibration = global.load_settings().vibration
	if sound==0:
		$SOUNDS/SOUNDS/ON.text = 'OFF'
		$SOUNDS/anim.play('off')
	if vibration==0:
		$VIBRATION/VIBRATION/ON.text = 'OFF'
		$VIBRATION/anim.play('off')
	pass

var sound = 1
var vibration = 1
var noads = 0

var world_speed = 3


func _on_LANGUAGE_released():
	if $LANGUAGE/LANGUAGE/ENG.text == 'RUS':
		$LANGUAGE/LANGUAGE/ENG.text = 'ENG'
		global.language = 0
		load_language()
		
	else:
		$LANGUAGE/LANGUAGE/ENG.text = 'RUS'	
		global.language = 1
		load_language()
		
	
func save():
	global.save_settings(sound, vibration, noads)

func load_language():
#	$SOUNDS/SOUNDS.text = gl.lang().so
#	$LANGUAGE/LANGUAGE.text = gl.lang().lang
#	$VIBRATION/VIBRATION.text = gl.lang().vi
#	$DISABLE_ADS/DISABLE_ADS.text = gl.lang().dis_ads
#	$REFREASH_IAP/REFRESH_IAP.text = gl.lang().re_iap
#	$SETTINGS.text = gl.lang().se
	pass
func _on_SOUNDS_released():
	if $SOUNDS/SOUNDS/ON.text == 'ON':
		$SOUNDS/SOUNDS/ON.text = 'OFF'
		$SOUNDS/anim.play('off')
		sound = 0
		save()
	else:
		$SOUNDS/SOUNDS/ON.text = 'ON'
		$SOUNDS/anim.play('on')
		sound = 1
		save()


func _on_VIBRATION_released():
	if $VIBRATION/VIBRATION/ON.text == 'ON':
		$VIBRATION/VIBRATION/ON.text = 'OFF'
		$VIBRATION/anim.play('off')
		vibration = 0
		save()
	else:
		$VIBRATION/VIBRATION/ON.text = 'ON'
		$VIBRATION/anim.play('on')
		vibration = 1
		save()


func _on_EXIT_released():
	get_tree().change_scene("res://scenes/menu_scene.tscn")
