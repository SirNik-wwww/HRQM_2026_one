extends EnemyMovementState
class_name IdleKirt1State

func enter() -> void:
	ANIM.play("idle")
	#print("i - IDLE IDLE idle !!!")

func update(delta : float) -> void:
	

	
	
	pass

func player_is_near():
	Trans.emit("ChaseKirtState")
