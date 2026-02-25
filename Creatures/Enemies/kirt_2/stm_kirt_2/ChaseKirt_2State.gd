class_name ChaseKirt_2State extends EnemyMovementState

#var player_is_close : bool = false
@export var nav_agent : NavigationAgent3D
@onready var recalc_timer: Timer = $"../../RecalcTimer"
#@onready var random_dir_timer: Timer = $"../../Random_dir_Timer".
@onready var raycast: RayCast3D = $"../../Raycast"


var is_rand_dir_setted : bool = false

func enter() -> void:
	is_rand_dir_setted = false
	ANIM.play("walk")

	recalc_timer.timeout.connect(_on_time_out)
	call_deferred("actor_setup")

	#random_dir_timer.timeout.connect(set_random_dir)
	#random_dir_timer.start(randf_range(1.0, 2.0))

func exit() -> void:
	#random_dir_timer.stop()
	pass


func update(delta : float) -> void:

	#if Input.is_action_just_pressed("-quick_debug"):
		#set_random_dir()

	var dir = PLAYER.global_position - SELF.global_position

#############################################################################
##_____________________________ ПЕРЕХОДЫ __________________________________##
	if PLAYER.is_dead == true:
		Trans.emit("StanKirt_2State")

	if SELF.lives <= 0:
		Trans.emit("DeadKirt_2State")

	#elif dir.length() > 14:
		#Trans.emit("IdleKirt_2State")

	#if player_is_close == true:
		#Trans.emit("AtkKirtState")

	#elif SELF.ATK_SHAPE_CAST.is_colliding() == true:
		#Trans.emit("AtkKirt_2State")


#############################################################################
##_______________________ передвижение ____________________________________##
	var cur_self_pos = SELF.global_position
	var next_path_pos = nav_agent.get_next_path_position()

	if dir.length() > 9:
		SELF.velocity.x = cur_self_pos.direction_to(next_path_pos).x * SELF._speed
		SELF.velocity.z = cur_self_pos.direction_to(next_path_pos).z * SELF._speed

	if 7 < dir.length() and dir.length() < 9:
		SELF.velocity.x = 0
		SELF.velocity.z = 0
		raycast.look_at(PLAYER.position)
		if raycast.is_colliding() == true and raycast.get_collider().is_in_group("Player") and SELF.atk_able == true:
			SELF.atk_able = false
			Trans.emit("AtkKirt_2State")

	if dir.length() < 7:
		SELF.velocity.x = next_path_pos.direction_to(cur_self_pos).x * SELF._speed
		SELF.velocity.z = next_path_pos.direction_to(cur_self_pos).z * SELF._speed

	#SELF.update_velocity()

func actor_setup() -> void:
	await get_tree().physics_frame
	set_target_pos(PLAYER.position)

func set_target_pos(terget_pos : Vector3) -> void:
	nav_agent.target_position = terget_pos

func _on_time_out() -> void:
	set_target_pos(PLAYER.position)
