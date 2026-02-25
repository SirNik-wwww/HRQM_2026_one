extends Area3D


func _on_body_entered(body: Node3D) -> void:
	#print("SUCCES")
	var body_vel = body.velocity.length()

	body_vel -= 6
	body_vel /= 2
	body_vel = snapped(body_vel, 1)
	if body_vel <= 0:
		pass
	else:
		print(body)
		if body.name == "Simple_player":
			Globus.player.PL_HP.take_damage(body_vel, true)
			#print("player")

		elif body is Hog:
			body.take_damage(body_vel * 56, true)
#
		#if body is Enemy_starter_pack and not Hog:
			#body.take_damage(body_vel, true)

		else:
			#print("player")
			body.take_damage(body_vel * 2, true)

	#print(body_vel)
