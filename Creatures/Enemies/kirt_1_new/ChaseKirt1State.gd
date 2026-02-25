extends EnemyMovementState
class_name ChaseKirt1State

func enter() -> void:
	ANIM.play("idle")
	#print("i - IDLE IDLE idle !!!")

func update(delta : float) -> void:
	pass
