class_name ChaseHogState extends EnemyMovementState

@export var nav_agent : NavigationAgent3D
@onready var recalc_timer: Timer = $"../../RecalcTimer"
@onready var random_ram_timer: Timer = $"../../RandomRam_timer"

var is_rand_dir_setted : bool = false



func enter() -> void:
	var rnd = randf_range(1.0, 4.3)
	random_ram_timer.start(rnd)
	SELF.can_move = true
	is_rand_dir_setted = false
	ANIM.play("walk")
	SELF.SPRITE.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y

	recalc_timer.timeout.connect(_on_time_out)
	call_deferred("actor_setup")

	#random_dir_timer.start(randf_range(1.0, 2.0))

func exit() -> void:
	random_ram_timer.stop()
	SELF.can_move = false
	#random_dir_timer.stop()
	#pass

func update(_delta : float) -> void:
	#var dir = PLAYER.global_position - SELF.global_position

#############################################################################
##_____________________________ ПЕРЕХОДЫ __________________________________##
	if PLAYER.is_dead == true:
		Trans.emit("StanHogState")

	elif SELF.lives <= 0:
		return

	elif SELF.ATK_SHAPE_CAST.is_colliding() == true:
		Trans.emit("AtkHogState")


#############################################################################
##_______________________ передвижение ____________________________________##
	var cur_self_pos = SELF.global_position
	var next_path_pos = nav_agent.get_next_path_position()

	if is_rand_dir_setted == false and SELF.can_move == true:
		SELF.velocity.x = cur_self_pos.direction_to(next_path_pos).x * SELF.speed
		SELF.velocity.z = cur_self_pos.direction_to(next_path_pos).z * SELF.speed

	#SELF.update_velocity()

func actor_setup() -> void:
	await get_tree().physics_frame
	set_target_pos(PLAYER.position)

func set_target_pos(terget_pos : Vector3) -> void:
	nav_agent.target_position = terget_pos

func _on_time_out() -> void:
	set_target_pos(PLAYER.position)


func _on_random_ram_timer_timeout() -> void:
	Trans.emit("AtkHogState")
