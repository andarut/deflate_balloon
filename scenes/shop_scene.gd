extends Node2D

var count = 8

var savedcount = 0

var start_p = Vector2(0,0)
var current_p = Vector2(0,0)
var cc_p = 0.0
var end_p = Vector2(0,0)

var start_pos = 0.0

var isScrolling = false

var speed_stop = 0.0
var pspeed_stop = 0.0

var maxscroll = 600

func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			start_pos = $scroll.position.y
			start_p = get_global_mouse_position()
			isScrolling = true
			print("START P: ", start_p)
		else:
			end_p = get_global_mouse_position()
			speed_stop = cc_p-end_p.y
			isScrolling = false
			print("END P: ", end_p)
		if isScrolling:
			speed_stop = (current_p.y - get_global_mouse_position().y)*-20
			
func _physics_process(delta):
	if isScrolling:
		current_p = get_global_mouse_position()
		$scroll.position.y = start_pos-(start_p.y-current_p.y)
		print("CURRENT P: ", start_p)
		if $scroll.position.y > 0:
			$scroll.position.y -= $scroll.position.y/1.4
		if $scroll.position.y < -maxscroll:
			$scroll.position.y += (-maxscroll-$scroll.position.y)/1.4
	else:
		if speed_stop!= 0:
			if $scroll.position.y > 0:
				$scroll.position.y -= $scroll.position.y/10
				speed_stop = 0
			if $scroll.position.y < -maxscroll:
				$scroll.position.y += (-maxscroll-$scroll.position.y)/10
				speed_stop = 0
		else:
			if $scroll.position.y > 0:
				$scroll.position.y -= $scroll.position.y/10
			if $scroll.position.y < -maxscroll:
				$scroll.position.y += (-maxscroll-$scroll.position.y)/10
		
		if speed_stop > 3:
			$scroll.position.y -= speed_stop
			speed_stop -= 4
		elif speed_stop < -3:
			$scroll.position.y -= speed_stop
			speed_stop += 4
		else:
			speed_stop = 0

func _ready():
	savedcount = global.load_skincount();
	for i in range(1,count+1):
		get_node('scroll/shop_btn'+str(i)).btn_ID = i
	pass
	load_skins()
	$anime.play('show')
	savedcount = global.load_skincount()
	print('LOADED COUNT SKIN DATA: ', savedcount)
	print(count)
	$topgui/coins/count.text = str(global.get_money())
	$scroll/shop_btn2.skin_id = 1
	$scroll/shop_btn3.skin_id = 2
	$scroll/shop_btn4.skin_id = 3
	$scroll/shop_btn5.skin_id = 4
	$scroll/shop_btn6.skin_id = 5
	$scroll/shop_btn7.skin_id = 6
	$scroll/shop_btn8.skin_id = 7
	
	$scroll/shop_btn1.buyed = true
	$scroll/shop_btn1/anime.play('fastbuy')
	$scroll/shop_btn2.price = 10
	$scroll/shop_btn3.price = 100
	$scroll/shop_btn4.price = 200
	$scroll/shop_btn5.price = 500
	$scroll/shop_btn6.price = 1000
	$scroll/shop_btn7.price = 2000
	$scroll/shop_btn8.price = 2000
	
var world_speed = 3

func select(id):
	for i in range(1,count+1):
		if i != id:
			get_node('scroll/shop_btn'+str(i)).selected = false
			get_node('scroll/shop_btn'+str(i)+'/select_anime').play('unselect')
	save()
	
func load_skins():
	var load_data = global.load_skins()
	print(savedcount)
	if not load_data == null:
		print('yay')
		for i in range(1,count+1):
			print('yay x2')
			if i <= savedcount:
				print('yay x3')
				if load_data["skin"+str(i)+"_b"]==1:
					get_node('scroll/shop_btn'+str(i)).buyed = true
					get_node('scroll/shop_btn'+str(i)+'/anime').play('fastbuy')
				if load_data["skin"+str(i)+"_s"]:
					get_node('scroll/shop_btn'+str(i)).selected = true
					get_node('scroll/shop_btn'+str(i)+'/select_anime').play('select')
	
			
func save():
	var save_data = "{"
	for i in range(1,count+1):
		var b = 0
		var s = 0
		if get_node('scroll/shop_btn'+str(i)).buyed:
			b = 1
		else:
			b = 0
		if get_node('scroll/shop_btn'+str(i)).selected:
			s = 1
		else:
			s = 0
			
		save_data += '"skin'+str(i)+'_b" : '+str(b)+", "
		var z = ","
		if i == count:
			z = ""
		save_data += '"skin'+str(i)+'_s" : '+str(s)+z+" "
	save_data+="}"
	print(save_data)
	global.save_skins(save_data)
	global.save_skincount(count)
	print("COUNT IN SAVE: ", count)
	$topgui/coins/count.text = str(global.get_money())
	
func buu():
	$topgui/coins/count/anime.play('minus')
	

func _on_back_btn_released():
	get_tree().change_scene("res://scenes/menu_scene.tscn")


func _on_Timer_timeout():
	cc_p = current_p.y
