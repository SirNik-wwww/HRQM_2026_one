extends CharacterBody3D

var actived = false

func take_damage(how_much = 1, is_it_damage := true):
	if actived == false:
		actived = !actived
		how_much = how_much
		is_it_damage = is_it_damage
		#get_tree().create_tween()
		#$Sprite3D/Sprite3D.rotate_z(rad_to_deg(10))
		#$Sprite3D/Sprite3D.position.y -= 0.5
		$AnimationPlayer.play("hide")

func move(sffdf):
	sffdf = sffdf
	
