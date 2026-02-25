class_name ChaseBandit_RState extends EnemyMovementState

@export var nav_agent : NavigationAgent3D
@onready var recalc_timer: Timer = $"../../RecalcTimer"
@onready var raycast: RayCast3D = $"../../raycast_holder/Raycast"


func enter() -> void:
	ANIM.play("walk")

	recalc_timer.timeout.connect(_on_time_out)
	call_deferred("actor_setup")



func update(_delta : float) -> void:
	var _dir = PLAYER.global_position - SELF.global_position

#############################################################################
##_____________________________ ПЕРЕХОДЫ __________________________________##
	if PLAYER.is_dead == true:
		Trans.emit("StanBandit_RState")

	elif SELF.lives <= 0:
		return


#############################################################################
##_______________________ передвижение ____________________________________##
	var cur_self_pos = SELF.global_position
	var next_path_pos = nav_agent.get_next_path_position()

	if SELF.can_move == true:
		if _dir.length() >= 9:
			SELF.velocity.x = cur_self_pos.direction_to(next_path_pos).x * SELF.speed
			SELF.velocity.z = cur_self_pos.direction_to(next_path_pos).z * SELF.speed

		if 7 < _dir.length() and _dir.length() < 9:
			SELF.velocity.x = 0
			SELF.velocity.z = 0
			raycast.look_at(PLAYER.position)
			if raycast.is_colliding() == true and raycast.get_collider().is_in_group("Player") and SELF.can_atk == true:
				SELF.can_atk = false
				Trans.emit("AtkBandit_RState")

		if _dir.length() <= 7:
			#var away_distance
			var dir_away = (SELF.global_position - PLAYER.global_position).normalized()
			var away_pos = SELF.global_position + dir_away
			set_target_pos(away_pos)
			next_path_pos = nav_agent.get_next_path_position()
			SELF.velocity.x = cur_self_pos.direction_to(next_path_pos).x * SELF.speed
			SELF.velocity.z = cur_self_pos.direction_to(next_path_pos).z * SELF.speed


func actor_setup() -> void:
	await get_tree().physics_frame
	set_target_pos(PLAYER.position)

func set_target_pos(terget_pos : Vector3) -> void:
	nav_agent.target_position = terget_pos

func _on_time_out() -> void:
	set_target_pos(PLAYER.position)
