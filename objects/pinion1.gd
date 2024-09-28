extends Sprite

func _ready():
	$animation.play('rotating')
	pass


func _on_Area2D_body_entered(body):
	if body.has_method("death"):
		body.death()
