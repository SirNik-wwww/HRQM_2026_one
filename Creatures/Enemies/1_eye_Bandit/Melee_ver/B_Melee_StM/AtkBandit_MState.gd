class_name AtkBandit_MState extends EnemyMovementState


func enter() -> void:

	SELF.velocity.x = 0
	SELF.velocity.z = 0

	ANIM.play("atk")
	$"../../Atk_commit/Pre_Atk".play()
	await ANIM.animation_finished

	if SELF.lives <= 0:
		return

	ANIM.play("atk_commit")
	$"../../Atk_commit".play()
	$"../../MeshInstance3D".look_at(PLAYER.position)
	$"../../MeshInstance3D".rotation.x = 0
	$"../../MeshInstance3D".rotation.z = 0

	SELF.SPRITE.rotation.y = $"../../MeshInstance3D".rotation.y
	SELF.SPRITE.rotate_y(deg_to_rad(180))
	SELF.SPRITE.billboard = BaseMaterial3D.BILLBOARD_DISABLED
	$"../../MeshInstance3D/Sprite3D".visible = true
	if SELF.ATK_SHAPE_CAST.is_colliding() == true and SELF.can_atk == true:
		PLAYER.PL_HP.take_damage(2, true)
	await ANIM.animation_finished
	$"../../MeshInstance3D/Sprite3D".visible = false
	SELF.SPRITE.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y

	if SELF.lives <= 0:
		return

	Trans.emit("ChaseBandit_MState")
