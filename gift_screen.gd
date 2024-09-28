extends Node2D

#onready var global = get_node('/root/global')

var world_speed = 3

func _ready():
	$light/rotating.play('rot')
	$anim.play('show')
	$count.text = "+"+str(global.gift_count)
	global.save_ch(1, int(global.load_ch().lvl)+1)
	global.save_money(int(global.get_money())+global.gift_count)




func _on_TouchScreenButton_released():
	get_tree().change_scene("res://scenes/chalenges_scene.tscn")
