class_name StanKirtState extends EnemyMovementState

func enter() -> void:

	ANIM.play("idle")
	SELF.velocity.x = 0
	SELF.velocity.z = 0
