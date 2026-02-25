class_name ChaseBandit_MState extends EnemyMovementState

@export var nav_agent : NavigationAgent3D
@onready var recalc_timer: Timer = $"../../RecalcTimer"
@onready var random_dir_timer: Timer = $"../../Random_dir_Timer"

var is_rand_dir_setted : bool = false



func enter() -> void:
	SELF.can_move = true
	is_rand_dir_setted = false
	ANIM.play("walk")

	recalc_timer.timeout.connect(_on_time_out)
	call_deferred("actor_setup")

	random_dir_timer.timeout.connect(set_random_dir)
	random_dir_timer.start(randf_range(1.0, 2.0))

func exit() -> void:
	SELF.can_move = false
	random_dir_timer.stop()
	#pass

func update(_delta : float) -> void:
	#var dir = PLAYER.global_position - SELF.global_position

#############################################################################
##_____________________________ ПЕРЕХОДЫ __________________________________##
	if PLAYER.is_dead == true:
		Trans.emit("StanBandit_MState")

	elif SELF.lives <= 0:
		return

	elif SELF.ATK_SHAPE_CAST.is_colliding() == true:
		Trans.emit("AtkBandit_MState")


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



#############################################################################
##______Магия которая заставляет двигаться в рандомном направлении________###
func set_random_dir():
	#if walk_able == true:
	var rand_dir = Vector3(randf_range(1.0, -1.0), 0, randf_range(1.0, -1.0)) # генерация рандомного направления
	is_rand_dir_setted = true # отключение основного передвижения

	SELF.velocity.x = rand_dir.x * SELF.speed
	SELF.velocity.z = rand_dir.z * SELF.speed

	#if random_dir_timer != null:
	get_tree().create_timer(randf_range(0.7, 2.0)).connect("timeout", Callable(self, "set_random_dir_part_2")) # время которое будет идти противник

func set_random_dir_part_2():
	random_dir_timer.start(randf_range(2.0, 4.0)) # время до следующего вызова
	is_rand_dir_setted = false


func _on_random_dir_timer_timeout() -> void:
	#if walk_able == true:
	set_random_dir()
