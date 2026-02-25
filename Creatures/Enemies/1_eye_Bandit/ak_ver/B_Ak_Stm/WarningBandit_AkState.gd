class_name WarningBandit_AkState extends EnemyMovementState

func enter() -> void:
	$"../../CPUParticles3D".emitting = true
	SELF.visible = true
	#SELF.rotation = 0
	ANIM.play("warning")
	await ANIM.animation_finished
	Trans.emit("ChaseBandit_AkState")

func exit() -> void:
	SELF.beatable = true
