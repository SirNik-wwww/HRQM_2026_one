class_name IdleKirt_2State extends EnemyMovementState

func enter() -> void:
	ANIM.play("idle")
	#print("i - IDLE IDLE idle !!!")

func update(delta : float) -> void:

	#SELF.update_velocity()

	var dir = PLAYER.global_position - SELF.global_position

	#if dir.length() < 11:
		#Trans.emit("ChaseKirt_2State")

	#SELF.velocity.x = 0
	#SELF.velocity.z = 0
