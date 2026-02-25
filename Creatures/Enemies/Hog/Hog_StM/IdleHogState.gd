class_name IdleHogState extends EnemyMovementState

func enter() -> void:
	#$"../ChaseBandit_MState".warning_anim_played = false
	ANIM.play("idle")
	SELF.velocity.x = 0
	SELF.velocity.z = 0
