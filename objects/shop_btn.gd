extends TouchScreenButton

onready var gl = get_node('/root/global')
onready var sound = global.load_settings().sound

var buyed = false
var selected = false
var price = 100

var skin_id = 0

var btn_ID = 1

func ready():
	$Label.text = str(price)
	
func _physics_process(delta):
	$skin_anime.play('s'+str(skin_id))
	$Label.text = str(price)


func buy():
	global.save_money(int(global.get_money())-price)
	buyed = true
	$anime.play('buyed')
	get_node('../../').save()
	get_node('../../').buu()
	if sound==1:
		$buy_sound.play()
	
func select():
	selected = true
	$select_anime.play('select')
	get_node('../../').select(btn_ID)
	global.save_skin_select(skin_id)
	if sound==1:
		$btn_sound.play()
	

func _on_shop_btn_released():
	if get_global_mouse_position().y>160:
		print("TOUCHES R: ",get_node('../../').current_p.y - get_node('../../').start_p.y)
		if (get_node('../../').current_p.y - get_node('../../').start_p.y > 10 && get_node('../../').end_p.y - get_node('../../').start_p.y < -10) || get_node('../../').current_p.y - get_node('../../').start_p.y == 0:
			if not buyed:
				var money = int(global.get_money())
				if money >= price:
					buy()
				return
			if buyed:
				select()
