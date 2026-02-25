class_name StanBandit_RState extends EnemyMovementState

func enter() -> void:

	ANIM.pause()
	SELF.can_move = false
	SELF.velocity.x = 0
	SELF.velocity.z = 0
