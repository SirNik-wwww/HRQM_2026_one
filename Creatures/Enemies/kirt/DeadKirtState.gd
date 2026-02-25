extends EnemyMovementState
class_name DeadKirtState

func enter() -> void:
	#SELF.velocity = 0
	ANIM.play("die")
	#SELF.die()
