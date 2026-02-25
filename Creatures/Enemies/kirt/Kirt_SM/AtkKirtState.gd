class_name AtkKirtState extends EnemyMovementState


func enter() -> void:

	SELF.velocity.x = 0
	SELF.velocity.z = 0

	ANIM.play("atk")
	await ANIM.animation_finished

	if SELF.lives <= 0:
		Trans.emit("DeadKirtState")

	ANIM.play("akt_commit")
	if SELF.ATK_SHAPE_CAST.is_colliding() == true:
		PLAYER.PL_HP.take_damage(2, true)
	await ANIM.animation_finished

	if SELF.lives <= 0:
		Trans.emit("DeadKirtState")

	Trans.emit("ChaseKirtState")
