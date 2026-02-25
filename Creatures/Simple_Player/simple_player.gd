class_name Player extends CharacterBody3D

#@export var stats : TestStats

var gravity = 12.0

#signal test_signal_what_does_nothing


@export var inf_hp = true
@export var inf_dmg = false

var is_dead = false
var input_able = true
var coun_atk_ready = false
var dgm_received : int

@export var SPEED_DF = 5.0
@export var SPEED_CR = 2.0
@export var SPEED_RN = 11.0
#@export var JUMP_VEL = 4.0
var _speed : float
var acceleration = 0.1
var deceleration = 0.25

@export var Footsteps_stream : AudioStreamPlayer

@export var NUNCH : Node3D
@export var L_GUN : Node3D
@export var CURSED_R : Node3D
@export var BOOM_BOX : Node3D
@export var ANVIL_GUN : Node3D

@export var PIG_COL : Node3D
@export var PL_HP : Node3D
@export var ANIM_PL : AnimationPlayer # для присяда
@export var ANIM_PL_2 : AnimationPlayer # для камеры при ходьбе
@export var CROUCH_SC : ShapeCast3D # SHAPECAST

@export var MOUSE_SENS : float = 0.2
@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)
@export var CAMERA_CONTROLLER : Camera3D
@export var INTERFACE : SubViewportContainer

@export var TARGET : Node3D


var mouse_input = false # для захвата мыши
var mouse_rot : Vector3 # для захвата мыши
var rot_input : float # для захвата мыши - x value
var tilt_input : float # для захвата мыши - y value
var pl_rot : Vector3 # поворот игрока за камерой
var cam_rot : Vector3 # поворот игрока за камерой
var cur_rot : float
var target_rot : Vector3 # Для стрельбы

@export var TOGGLE_CROUCH_MOD : bool = false
var is_crouching = false
var crouch_anim_speed = 7.0 # насколько быстро игрок будет присядать
var crouch_speed_dolg = false ###    (МУСОР???)     эта штука нужна чтобы контралировать скорость при присяде
var crouch_j_ver = false
var crouch_speed_state = false

@export var TOGGLE_RUN_MOD : bool = false ### ???
var run_state = false ### ???
var is_running : bool = false # надо для того, чтобы анимация бега не сбрасывалась от сталкновений

@onready var cross: Label = $Interface/cross #просто перекрестье 

# Отладка оружия____________

enum Weapons {NUNCH, LEFT_GUN, CURSED_R, BOOM_BOX, ANVIL_GUN, NONE}
var current_weapon := Weapons.NUNCH
#___________________________

func _ready() -> void:
	is_dead = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	CROUCH_SC.add_exception($".")
	#CROUCH_SC.add_exception($Cam_Contr/Cam_Contr_2/Camera3D/Weapons/Nunchucks/atk_ShapeCast) ## НАДО ЛИ ????

	_speed = SPEED_DF

	Globus.player = self

	input_able = true

####################
	weapon_debug()
####################

#################################################################
##_______________________Инпут_________________________________##
func _input(event):
	if Input.is_action_just_pressed("-debug_q"):
		weapon_debug()

	if event.is_action_pressed("-quick_debug(1)"):
		velocity.y += 5
	if event.is_action_pressed("-inf_hp"):
		inf_hp = !inf_hp
	if event.is_action_pressed("-inf_dmg"):
		inf_dmg = !inf_dmg

	if input_able == true:

	#________________ Режим присяда по нажатию:
		if event.is_action_pressed("_crouch") and TOGGLE_CROUCH_MOD == true:
			toggle_crouch()
			crouch_speed_func()

	#________________ Режим присяда при зажимании:
		if event.is_action_pressed("_crouch") and is_crouching == false and TOGGLE_CROUCH_MOD == false:
			crouching(true)
			crouch_speed_state = true
			crouch_speed_func()
		if event.is_action_released("_crouch") and TOGGLE_CROUCH_MOD == false:
			if CROUCH_SC.is_colliding() == false:
				crouching(false)
				crouch_speed_state = false
				crouch_speed_func()
			elif CROUCH_SC.is_colliding() == true:
				uncrouch_check()



	#______________ Бег:
		if event.is_action_pressed("_run") and is_crouching == false and is_on_floor() and TOGGLE_RUN_MOD == false:
			_speed = SPEED_RN
			is_running = true
		if event.is_action_released("_run") and is_crouching == false and TOGGLE_RUN_MOD == false:
			run_speed_func()

		if event.is_action_pressed("_run") and is_crouching == false and is_on_floor() and TOGGLE_RUN_MOD == true:
			pass 
		#### ЭТО НАДО???



#______________ Мышь и камера:
func _unhandled_input(event):
	if input_able == true:

		mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
		if mouse_input:
			rot_input = -event.relative.x * MOUSE_SENS
			tilt_input = -event.relative.y * MOUSE_SENS

func update_cam(delta):
	if input_able == true:

		cur_rot = rot_input

		mouse_rot.x += tilt_input * delta
		mouse_rot.x = clamp(mouse_rot.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
		mouse_rot.y += rot_input * delta

		pl_rot = Vector3(0.0, mouse_rot.y, 0.0)
		cam_rot = Vector3(mouse_rot.x, 0.0, 0.0)
		target_rot = Vector3(mouse_rot)


		CAMERA_CONTROLLER.transform.basis = Basis.from_euler(cam_rot)
		CAMERA_CONTROLLER.rotation.z = 0.0
		TARGET.transform.basis = Basis.from_euler(target_rot)

		global_transform.basis = Basis.from_euler(pl_rot)

		rot_input = 0.0
		tilt_input = 0.0



#################################################################
##_______________________Физика________________________________##
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if input_able == true:

		var input_dir = Input.get_vector("+a", "+d", "+w", "+s")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = lerp(velocity.x,direction.x * _speed, acceleration)
			velocity.z = lerp(velocity.z,direction.z * _speed, acceleration)
		else:
			velocity.x = move_toward(velocity.x, 0, deceleration)
			velocity.z = move_toward(velocity.z, 0, deceleration)


	Globus.debug.add_prop("Move_Speed", velocity.length(), 1) # Эта строчка выводит нужную инфу в дебаг
	# первым идёт назвае в дебаге (любое) -> нужная переменная -> цыфра обозначает на какой строчке будет инфа

	update_cam(delta)

	move_and_slide()


func pich_sound():
	$AnimationPlayer_for_camera/Footsteps.pitch_scale = randf_range(0.95, 1.05)


func its_player(): # функция которая есть только у игрока
	pass


#################################################################
##_______________________БЕГ___________________________________##
func run_speed_func():
	if is_on_floor():
		is_running = false
		_speed = SPEED_DF
	else:
		await get_tree().create_timer(0.1).timeout
		run_speed_func()




#################################################################
##_______________________ПРИCЯД________________________________##
func toggle_crouch():
	if is_crouching == true and CROUCH_SC.is_colliding() == false:
		crouch_speed_state = false
		crouching(false)
	elif is_crouching == false:
		crouch_speed_state = true
		crouching(true)



func crouching(state : bool):
	match state:
		true:
			if is_on_floor():
				ANIM_PL.play("crouch", -1, crouch_anim_speed)
			else:
				ANIM_PL.play("crouch_jump", -1, crouch_anim_speed)
				crouch_j_ver = true
		false:
			if crouch_j_ver == false:
				ANIM_PL.play("crouch", -1, -crouch_anim_speed, true)
			if crouch_j_ver == true:
				ANIM_PL.play("crouch_jump", -1, -crouch_anim_speed, true)
				crouch_j_ver = !crouch_j_ver
			is_crouching = false #### Это нужно для фикса бага
			# если быстро нажать и сразу отпустить присяд с бегом, то они могут сломаться
			# Эта строчка решает проблему,    вроде



func crouch_speed_func():
	if crouch_speed_state == true:
		if is_on_floor():
			_speed = SPEED_CR
		else:
			await get_tree().create_timer(0.1).timeout
			crouch_speed_func()
	else:
		_speed = SPEED_DF



func uncrouch_check():
	if CROUCH_SC.is_colliding() == false:
		crouching(false)
		crouch_speed_state = false
		crouch_speed_func()
	if CROUCH_SC.is_colliding() == true:
		await get_tree().create_timer(0.1).timeout
		uncrouch_check()



func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "crouch" or "crouch_jump":
		is_crouching = !is_crouching



##############################################################
###__________________ Сохранение ___________________________##
#func on_save_game(saved_data : Array[SavedData]):
	#var my_data = SavedData.new()
	#my_data.pos = global_position
	#my_data.scene_path = scene_file_path
	#my_data.groups = get_groups()
#
	#saved_data.append(my_data) # переделывает в аррей????
#
#func on_before_load():
	#get_parent().remove_child(self)
	#queue_free()
#
#func on_load_game(saved_data : SavedData):
	#global_position = saved_data.pos
	#for group in saved_data.groups:
		#add_to_group(group)
##############################################################
##############################################################
func weapon_debug():
	L_GUN.visible = false
	L_GUN.process_mode = Node.PROCESS_MODE_DISABLED
	NUNCH.visible = false
	NUNCH.process_mode = Node.PROCESS_MODE_DISABLED
	CURSED_R.visible = false
	CURSED_R.process_mode = Node.PROCESS_MODE_DISABLED
	BOOM_BOX.visible = false
	BOOM_BOX.process_mode = Node.PROCESS_MODE_DISABLED
	ANVIL_GUN.visible = false
	ANVIL_GUN.process_mode = Node.PROCESS_MODE_DISABLED
	match current_weapon:
		Weapons.NUNCH:
			NUNCH.visible = true
			NUNCH.process_mode = Node.PROCESS_MODE_INHERIT
			current_weapon = Weapons.LEFT_GUN
		Weapons.LEFT_GUN:
			L_GUN.visible = true
			L_GUN.process_mode = Node.PROCESS_MODE_INHERIT
			current_weapon = Weapons.CURSED_R
		Weapons.CURSED_R:
			CURSED_R.visible = true
			CURSED_R.process_mode = Node.PROCESS_MODE_INHERIT
			current_weapon = Weapons.BOOM_BOX
		Weapons.BOOM_BOX:
			BOOM_BOX.visible = true
			BOOM_BOX.process_mode = Node.PROCESS_MODE_INHERIT
			current_weapon = Weapons.NUNCH
		Weapons.ANVIL_GUN:
			ANVIL_GUN.visible = true
			ANVIL_GUN.process_mode = Node.PROCESS_MODE_INHERIT
			current_weapon = Weapons.NONE
		Weapons.NONE:
			current_weapon = Weapons.NUNCH
