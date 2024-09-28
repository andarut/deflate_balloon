extends Node2D

var sec = 0

func _ready():
	$logo/anim.play('show')

func _physics_process(delta):
	sec+=delta
	if sec >= 5:
		get_tree().change_scene("res://scenes/menu_scene.tscn")
