class_name WarningBandit_MState extends EnemyMovementState

func enter() -> void:
	ANIM.play("warning")
	await ANIM.animation_finished
	Trans.emit("ChaseBandit_MState")
