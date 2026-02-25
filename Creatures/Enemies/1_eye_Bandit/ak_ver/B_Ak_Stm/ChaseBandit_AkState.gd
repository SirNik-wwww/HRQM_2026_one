class_name ChaseBandit_AkState extends EnemyMovementState

@export var nav_agent : NavigationAgent3D
@onready var recalc_timer: Timer = $"../../RecalcTimer"
@onready var raycast: RayCast3D = $"../../raycast_holder/Raycast"


func enter() -> void:
	SELF.can_move = true
	ANIM.play("reload")
	await ANIM.animation_finished
	#call_deferred("actor_setup")
	Trans.emit("AtkBandit_AkState")


func update(_delta : float) -> void:

	if PLAYER.is_dead == true:
		Trans.emit("StanBandit_AkState")

	elif SELF.lives <= 0:
		return

	#Trans.emit("AtkBandit_AkState")

#func actor_setup() -> void:
	#await get_tree().physics_frame
	#set_target_pos(PLAYER.position)
#
#func set_target_pos(terget_pos : Vector3) -> void:
	#nav_agent.target_position = terget_pos
#
#func _on_time_out() -> void:
	#set_target_pos(PLAYER.position)
