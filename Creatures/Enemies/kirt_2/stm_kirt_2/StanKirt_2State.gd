class_name StanKirt_2State extends EnemyMovementState

func enter() -> void:
	
	ANIM.pause()
	SELF.velocity.x = 0
	SELF.velocity.z = 0
