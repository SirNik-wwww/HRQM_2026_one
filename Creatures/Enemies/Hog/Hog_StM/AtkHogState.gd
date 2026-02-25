class_name AtkHogState extends EnemyMovementState



func enter() -> void:
	SELF.can_atk = false
	SELF.velocity.x = 0
	SELF.velocity.z = 0

	ANIM.play("atk")
	$"../../Atk_commit/Pre_Atk".play()
	await ANIM.animation_finished

	if SELF.lives <= 0:
		return

	if PLAYER.is_dead == true:
		Trans.emit("StanBandit_RState")
		return

	if SELF.lives <= 0:
		return

	else:
		pass


	ANIM.play("atk_commit")
	SELF.can_atk = true
	$"../../Ram_timer".start()
	$"../../Atk_commit".play()
	$"../../MeshInstance3D".look_at(PLAYER.position)
	$"../../MeshInstance3D".rotation.x = 0
	$"../../MeshInstance3D".rotation.z = 0


	SELF.SPRITE.rotation.y = $"../../MeshInstance3D".rotation.y
	SELF.SPRITE.rotate_y(deg_to_rad(180))
	SELF.SPRITE.billboard = BaseMaterial3D.BILLBOARD_DISABLED
	var vec_to_pl = SELF.global_position - Globus.player.global_position
	SELF.velocity.x = -vec_to_pl.normalized().x * SELF.speed * 4
	SELF.velocity.z = -vec_to_pl.normalized().z * SELF.speed * 4

	


	await $"../../Ram_timer".timeout
	SELF.SPRITE.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y
	
	SELF.can_atk = false
	if SELF.lives <= 0:
		return

	Trans.emit("ChaseHogState")

#func update(_delta: float) -> void:
	#if SELF.ATK_SHAPE_CAST.is_colliding() == true and SELF.can_atk == true:
		#if SELF.ATK_SHAPE_CAST.get_collider(0) is Player:
			#PLAYER.PL_HP.take_damage(2, true)
		#else:
			#if SELF.ATK_SHAPE_CAST.is_colliding():
				#var target = SELF.ATK_SHAPE_CAST.get_collider(0)
				#target.take_damage(5, true)
	#hitted = $"../../Area_for_dmg".get_overlapping_areas()


func _on_area_for_dmg_body_entered(body: Node3D) -> void:
	if SELF.can_atk == true and body is not Hog:
		
		#pass
		#if body != Globus.player:
			#body.take_damage(5, true)
			##print("player")
		#else:
			#PLAYER.PL_HP.take_damage(2, true)
		if body is Player:
			PLAYER.PL_HP.take_damage(2, true)
		else:
			var hitted = $"../../Area_for_dmg".get_overlapping_areas()
			#print(body)
			for en in hitted:
				if en.has_method("take_damage"):
					en.take_damage(5, true)
			if body.has_method("take_damage"):
				body.HURT_BOX.take_damage(5, true)
				body.HURT_BOX.move("up")
	#just_spawned = false
