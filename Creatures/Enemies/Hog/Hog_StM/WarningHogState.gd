class_name WarningHogState extends EnemyMovementState

func enter() -> void:
	#SELF.rotation = 0

	ANIM.play("warning")
	await ANIM.animation_finished
	Trans.emit("ChaseHogState")
