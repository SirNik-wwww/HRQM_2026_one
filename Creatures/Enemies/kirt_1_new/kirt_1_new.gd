extends CharacterBody3D

@onready var anim_sp_pl: AnimatedSprite3D = $AnimatedSprite3D
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var recalc_timer: Timer = $RecalcTimer


var jump_vel = 6.0
var _speed = 3.0
var gravity = 12.0
var lives = 10

var beatable = true
var dir
var chase_var = false
var atk_proc = false
var dead : bool = false

var PLAYER : Player



func _ready() -> void:
	PLAYER = Globus.player
	recalc_timer.timeout.connect(_on_time_out)

	call_deferred("actor_setup")


func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y -= gravity * delta

	if nav_agent.is_navigation_finished():
		return

	var cur_self_pos = global_position
	var next_path_pos = nav_agent.get_next_path_position()


	velocity.x = cur_self_pos.direction_to(next_path_pos).x * _speed
	velocity.z = cur_self_pos.direction_to(next_path_pos).z * _speed

	move_and_slide()



##________________ Нахождение пути ____________________##
func actor_setup() -> void:
	await get_tree().physics_frame
	set_target_pos(PLAYER.position)

func set_target_pos(terget_pos : Vector3) -> void:
	nav_agent.target_position = terget_pos

func _on_time_out() -> void:
	set_target_pos(PLAYER.position)
##_____________________________________________________##


########################################################
##_____________ Здоровье и смерть ____________________##
func damage():
	if beatable == true:
		beatable = !beatable
		if lives >= 1:
			anim_sp_pl.modulate = Color(1, 0, 0)
			await get_tree().create_timer(0.2).timeout

			anim_sp_pl.modulate = Color(1, 1, 1)
			beatable = !beatable
		else:
			anim_sp_pl.modulate = Color(1, 0, 0)
			die()

func die():
	dead = true
	chase_var = false
	beatable = false
	anim_sp_pl.play("die")
	await get_tree().create_timer(1).timeout
	queue_free()
########################################################
########################################################



#############################################################
##__________________ Сохранение ___________________________##
func on_save_game(saved_data : Array[SavedData]):
	if dead == true:
		return
	var my_data = SavedData.new()
	my_data.pos = global_position
	my_data.scene_path = scene_file_path
	my_data.cur_hp = lives

	saved_data.append(my_data) # переделывает в аррей????

func on_before_load():
	get_parent().remove_child(self)
	queue_free()

func on_load_game(saved_data : SavedData):
	global_position = saved_data.pos
	lives = saved_data.cur_hp
#############################################################
#############################################################
