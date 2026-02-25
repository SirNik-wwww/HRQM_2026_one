extends Node3D

@export var PLAYER : Player

@export var SE_WOOSH : AudioStreamPlayer
@export var SE_WOOSH_SPEC : AudioStreamPlayer
@export var SE_HIT : AudioStreamPlayer 
@export var SE_HIT_SPEC : AudioStreamPlayer
@export var SE_LASER : AudioStreamPlayer


@export var CAM : Camera3D
@export var TARGET_DIR : Node3D
@export var TARGET : Node3D
@export var anim_pl : AnimationPlayer
@export var combo_text_small : Label
@export var combo_text_mid : Label
@export var combo_text : Label
@export var combo_timer : Timer
@export var nun_ShC : Node3D
@export var Bar : HBoxContainer
@export var Melee_spite : Sprite3D
@export var Combo_sp : Sprite3D
@export var COMBO_SP_2 : Sprite3D

@onready var canvas_layer_2: CanvasLayer = $CanvasLayer2

@onready var diagonal: RichTextLabel = $CanvasLayer2/Control/HBoxContainer/MarginContainer/MarginContainer/VBoxContainer/Diagonal
@onready var diagonal_2: RichTextLabel = $CanvasLayer2/Control/HBoxContainer/MarginContainer/MarginContainer/VBoxContainer/Diagonal_2
@onready var trigger_fingers: RichTextLabel = $CanvasLayer2/Control/HBoxContainer/MarginContainer/MarginContainer/VBoxContainer/TRIGGER_FINGERS
@onready var counterattack: RichTextLabel = $CanvasLayer2/Control/HBoxContainer/MarginContainer/MarginContainer/VBoxContainer/COUNTERATTACK
@onready var fck: RichTextLabel = $CanvasLayer2/Control/HBoxContainer/MarginContainer/MarginContainer/VBoxContainer/FCK
@onready var uppercut: RichTextLabel = $CanvasLayer2/Control/HBoxContainer/MarginContainer/MarginContainer/VBoxContainer/UPPERCUT
@onready var right_intrusion: RichTextLabel = $CanvasLayer2/Control/HBoxContainer/MarginContainer/MarginContainer/VBoxContainer/RIGHT_INTRUSION
@onready var left_extrusion: RichTextLabel = $CanvasLayer2/Control/HBoxContainer/MarginContainer/MarginContainer/VBoxContainer/LEFT_EXTRUSION
@onready var slap: RichTextLabel = $CanvasLayer2/Control/HBoxContainer/MarginContainer/MarginContainer/VBoxContainer/SLAP
@onready var dir: RichTextLabel = $CanvasLayer2/Control/HBoxContainer/MarginContainer/MarginContainer/VBoxContainer/DIR
@onready var curse_ball: RichTextLabel = $"CanvasLayer2/Control/HBoxContainer/MarginContainer/MarginContainer/VBoxContainer/CURSE-BALL"
@onready var fail: RichTextLabel = $CanvasLayer2/Control/HBoxContainer/MarginContainer/MarginContainer/VBoxContainer/Fail



const K_LEFT = preload("res://Creatures/Simple_Player/interface/combo/K_left.tscn")
const K_RIGHT = preload("res://Creatures/Simple_Player/interface/combo/K_right.tscn")
const K_MID = preload("res://Creatures/Simple_Player/interface/combo/K_mid.tscn")
const bullet_path = preload("res://Creatures/Simple_Player/weapons/cursed_ball_test.tscn")
const LASER_path = preload("res://Creatures/Simple_Player/weapons/laser_pl.tscn")

#const melee_spec_se = preload("res://Sound/SE/punches/(CUT_2)_artninja__custom_tmnt_2012_inspired_lowendheavyimpactpunch_with_and_without_whip_cracks_02192025.wav")
#const range_spec_se = preload("res://Sound/SE/punches/651023__nomiqbomi__lazer-01.mp3")

var combos = { 
"CHECK" : ["R", "L", "r"],
"DIAGONAL" : ["L", "L", "R"],
"DIAGONAL_2" : ["R", "R", "L"],
"TRIGGER_FINGERS" : ["R", "L", "R", "M"],
"COUNTERATTACK" : ["R", "M"],
"MIDDLE_FINGER" : ["M", "M", "M", "M"],
"UPPERCUT" : ["L", "M", "R", "M"],
"RIGHT_INTRUSION" : ["R", "R", "R", "R"],
"LEFT_EXTRUSION" : ["L", "L", "L", "L"],
"SLAP" : ["M", "R", "L"],
"PUSH" : ["R", "L", "R", "L"],
"BALL_DIR" : ["L", "R", "R", "L"],
#"BALL_DOWN" : ["L", "R", "R", "M"],

}

var akt_all = ["+mouse_right", "+mouse_left", "+mouse_mid"]

var cur_combo : Array
var input_able = true
var for_clear_combo = false
var always_true_var = true
var magic = false # она будет отвечать за очистку счётчика
var clean_timer_var = true # таймер для отчистки комбо
var combo_process : bool = false


var my_damage = 1
var di_dmg = 10
var di_2_dmg = 10
var finger_beam_dmg = 8
var coun_atk_dmg = 5
var coun_atk_used = false
var coun_atk_process = false
var uppercut_dmg = 5
var right_int_dmg = 5
var left_ext_dmg = 5
var dir_dmg = 5
var slap_dmg = 2
var ball_dmg = 10



func _ready() -> void:
	COMBO_SP_2.visible = false
	use_combo(false)
	anim_pl.play("idle")
	combo_text_small.text = ""

	var lt = get_tree().get_nodes_in_group("kombo_label")
	for l in lt:
		l.visible = false



func _input(event):
	if PLAYER.inf_dmg == true:
		my_damage = 10
	else :
		my_damage = 1

	if input_able == true and PLAYER.input_able == true:
	
		if event.is_action_pressed("+mouse_right"):
			Melee_spite.set_layer_mask(1)
			if magic == true:
				clear_bar()
			anim_pl.play("NULL")
			anim_pl.play("atk_right_ALT")
			player_atk()
			cur_combo += ["R"]
			var k_r = K_RIGHT.instantiate()
			Bar.add_child(k_r)



		elif event.is_action_pressed("+mouse_left"):
			Melee_spite.set_layer_mask(1)
			if magic == true:
				clear_bar()
			anim_pl.play("NULL")
			anim_pl.play("atk_left_ALT")
			player_atk()
			cur_combo += ["L"]
			var k_l = K_LEFT.instantiate()
			Bar.add_child(k_l)




		elif event.is_action_pressed("+mouse_mid"):
			Melee_spite.set_layer_mask(1)
			if magic == true:
				clear_bar()
			anim_pl.play("NULL")
			anim_pl.play("atk_mid_ALT")
			player_atk()
			cur_combo += ["M"]
			var k_m = K_MID.instantiate()
			Bar.add_child(k_m)

	#else:
		#return


#########################################################################
##_____________________ КОМБО _________________________________________##
	if cur_combo == combos["CHECK"]:
		combo_text.text = tr("KOMBO_CHECK")
		cur_combo = []
		input_able = false
		await anim_pl.animation_finished

		use_combo(true)
		
		anim_pl.play("ball-dir")
		await anim_pl.animation_finished

		use_combo(false)




	if cur_combo == combos["DIAGONAL"]:
		combo_text.text = tr("KOMBO_DIAGONAL")
		cur_combo = []
		input_able = false
		await anim_pl.animation_finished

		use_combo(true)
		diagonal.visible = true
		diagonal.text = tr("KOMBO_DIAGONAL") + " ◐ ◐ ◑"

		anim_pl.play("diagonal")
		CAM.apply_shake(0.03 + di_dmg/80, 7 + di_dmg)
		SE_WOOSH_SPEC.play()

		if nun_ShC.is_colliding():
			var target = nun_ShC.get_collider()
			target.take_damage(di_dmg, true)
			SE_HIT_SPEC.play()
		di_dmg -= 4
		await anim_pl.animation_finished

		use_combo(false)



	if cur_combo == combos["DIAGONAL_2"]:
		combo_text.text = tr("KOMBO_DIAGONAL_2")
		cur_combo = []
		input_able = false
		await anim_pl.animation_finished

		use_combo(true)
		diagonal_2.visible = true
		diagonal_2.text = tr("KOMBO_DIAGONAL_2") + " ◑ ◑ ◐"

		anim_pl.play("diagonal_2")
		CAM.apply_shake(0.06, 10)
		SE_WOOSH_SPEC.play()

		if nun_ShC.is_colliding():
			var target = nun_ShC.get_collider()
			target.take_damage(di_2_dmg, true)
			SE_HIT_SPEC.play()
		di_2_dmg -= 4
		await anim_pl.animation_finished

		use_combo(false)



	if cur_combo == combos["COUNTERATTACK"]:
		coun_atk_used = false
		combo_text.text = tr("KOMBO_COUNTERATTACK")
		cur_combo = []
		input_able = false
		await anim_pl.animation_finished

		use_combo(true)
		counterattack.visible = true
		counterattack.text = tr("KOMBO_COUNTERATTACK") + " ◑ ◓"

		PLAYER.coun_atk_ready = true
		anim_pl.play("coun_atk_1")
		await anim_pl.animation_finished

		if coun_atk_used != true:
			PLAYER.coun_atk_ready = false
			use_combo(false)



	if cur_combo == combos["TRIGGER_FINGERS"]:
		combo_text_mid.text = tr("KOMBO_TRIGGER_FINGERS")
		cur_combo = []
		input_able = false
		await anim_pl.animation_finished

		use_combo(true)
		trigger_fingers.visible = true
		trigger_fingers.text = tr("KOMBO_TRIGGER_FINGERS") + " ◑ ◐ ◑ ◓"

		SE_LASER.pitch_scale = randf_range(1.7, 2.0)
		SE_LASER.play()

		anim_pl.play("trigger_fingers")
		CAM.apply_shake(0.06, 10)
		var laser = LASER_path.instantiate()
		laser.position = TARGET.global_position
		laser.rotation = TARGET_DIR.rotation
		laser.dmg = finger_beam_dmg
		get_parent().add_child(laser)
		finger_beam_dmg -= 6
		await anim_pl.animation_finished

		use_combo(false)



	if cur_combo == combos["MIDDLE_FINGER"]:
		combo_text.text = tr("KOMBO_MIDDLE_FINGER")
		cur_combo = []
		input_able = false
		await anim_pl.animation_finished

		use_combo(true)
		fck.visible = true
		fck.text = tr("KOMBO_MIDDLE_FINGER") + " ◓ ◓ ◓ ◓"

		anim_pl.play("middle_finger")
		#COMBO_SP_2.visible = true
		await anim_pl.animation_finished
		#COMBO_SP_2.visible = false

		use_combo(false)



	if cur_combo == combos["RIGHT_INTRUSION"]:
		combo_text_small.text = tr("KOMBO_RIGHT_INTRUSION")
		cur_combo = []
		input_able = false
		await anim_pl.animation_finished

		use_combo(true)
		right_intrusion.visible = true
		right_intrusion.text = tr("KOMBO_RIGHT_INTRUSION") + " ◑ ◑ ◑ ◑"

		anim_pl.play("right_ext")
		CAM.apply_shake(0.03 + right_int_dmg/80, 7 + right_int_dmg)
		SE_WOOSH_SPEC.play()

		if nun_ShC.is_colliding():
			var target = nun_ShC.get_collider()
			target.take_damage(right_int_dmg, true)
			target.move("left")
			SE_HIT_SPEC.play()
		right_int_dmg -= 2
		await anim_pl.animation_finished

		use_combo(false)



	if cur_combo == combos["LEFT_EXTRUSION"]:
		combo_text_small.text = tr("KOMBO_LEFT_EXTRUSION")
		cur_combo = []
		input_able = false
		await anim_pl.animation_finished

		use_combo(true)
		left_extrusion.visible = true
		left_extrusion.text = tr("KOMBO_LEFT_EXTRUSION") + " ◐ ◐ ◐ ◐"

		anim_pl.play("left_int")
		CAM.apply_shake(0.03 + left_ext_dmg/80, 7 + left_ext_dmg)
		SE_WOOSH_SPEC.play()

		if nun_ShC.is_colliding():
			var target = nun_ShC.get_collider()
			target.take_damage(left_ext_dmg, true)
			target.move("right")
			SE_HIT_SPEC.play()
		left_ext_dmg -= 2
		await anim_pl.animation_finished

		use_combo(false)




	if cur_combo == combos["UPPERCUT"]:
		combo_text.text = tr("KOMBO_UPPERCUT")
		cur_combo = []
		input_able = false
		await anim_pl.animation_finished

		use_combo(true)
		uppercut.visible = true
		uppercut.text = tr("KOMBO_UPPERCUT") + " ◐ ◓ ◑ ◓"

		anim_pl.play("uppercut")
		CAM.apply_shake(0.03 + uppercut_dmg/80, 7 + uppercut_dmg)
		SE_WOOSH_SPEC.play()

		if nun_ShC.is_colliding():
			var target = nun_ShC.get_collider()
			target.take_damage(uppercut_dmg, true)
			target.move("up")
			SE_HIT_SPEC.play()
		uppercut_dmg -= 2
		await anim_pl.animation_finished

		use_combo(false)


	if cur_combo == combos["PUSH"]:
		combo_text.text = tr("KOMBO_PUSH")
		cur_combo = []
		input_able = false
		await anim_pl.animation_finished

		use_combo(true)
		dir.visible = true
		anim_pl.play("direct")
		CAM.apply_shake(0.03 + dir_dmg/80, 7 + dir_dmg)
		SE_WOOSH_SPEC.play()

		if nun_ShC.is_colliding():
			var target = nun_ShC.get_collider()
			target.take_damage(dir_dmg, true)
			target.move("forward")
			SE_HIT_SPEC.play()
		dir_dmg -= 2
		await anim_pl.animation_finished

		use_combo(false)



	if cur_combo == combos["SLAP"]:
		combo_text.text = tr("KOMBO_SLAP")
		cur_combo = []
		input_able = false
		await anim_pl.animation_finished

		use_combo(true)
		slap.visible = true
		slap.text = tr("KOMBO_SLAP") + " ◓ ◑ ◐"

		anim_pl.play("slap")
		CAM.apply_shake(0.03 + slap_dmg/80, 7 + slap_dmg)
		SE_WOOSH_SPEC.play()

		if nun_ShC.is_colliding():
			var target = nun_ShC.get_collider()
			target.take_damage(slap_dmg, true)
			SE_HIT_SPEC.play()
		slap_dmg += 3
		await anim_pl.animation_finished

		use_combo(false)



	if cur_combo == combos["BALL_DIR"]:
		combo_text_small.text = tr("KOMBO_BALL_DIR")
		cur_combo = []
		input_able = false
		await anim_pl.animation_finished
		use_combo(true)
		curse_ball.visible = true
		curse_ball.text = tr("KOMBO_BALL_DIR") + " ◐ ◑ ◑ ◐"

		anim_pl.play("ball-dir-1")
		await anim_pl.animation_finished

		anim_pl.play("ball-dir-2")
		SE_LASER.pitch_scale = randf_range(1.7, 2.0)
		SE_LASER.play()

		CAM.apply_shake(0.06, 10)
		var bullet = bullet_path.instantiate()
		bullet.position = TARGET.global_position
		bullet.rotation = TARGET_DIR.rotation
		bullet.dmg = ball_dmg
		get_parent().add_child(bullet)
		ball_dmg -= 6
		await anim_pl.animation_finished

		use_combo(false)



	elif cur_combo.size() >= 5:
		cur_combo = []
		combo_text.text = tr("KOMBO_FAIL")
		fail.visible = true
		fail.text = tr("KOMBO_FAIL") + " ¿◒ ◕ ◉ ◓?"

		for action in akt_all:
			if event.is_action_pressed(action):
				magic = true

		if clean_timer_var == true:
			clean_timer_var = !clean_timer_var
			combo_timer.start(2.0)
		refresh_combo()

	else:
		pass


func counterattak(dmg_received1 : int):
	if coun_atk_process != true:
		coun_atk_process = !coun_atk_process
		anim_pl.play("coun_atk_2")
		CAM.apply_shake(0.06, 10)
		var _dmg_0
		_dmg_0 = dmg_received1 * coun_atk_dmg
		if nun_ShC.is_colliding():
			var target = nun_ShC.get_collider()
			target.take_damage(_dmg_0, true)
			SE_HIT_SPEC.play()
		coun_atk_dmg -= 2
		#print(coun_atk_dmg + "sssss")
		await anim_pl.animation_finished

		use_combo(false)
		#await get_tree().create_timer(3.5).timeout
		PLAYER.coun_atk_ready = false
		coun_atk_process = !coun_atk_process


#########################################################################
#########################################################################

func _on_timer_timeout() -> void:
	clear_bar()



func player_atk():
	CAM.apply_shake(0.03, 7)
	SE_WOOSH.play()

	if nun_ShC.is_colliding():
		var target = nun_ShC.get_collider()
		target.take_damage(my_damage, true)
		SE_HIT.pitch_scale = randf_range(1.31, 2.11)
		SE_HIT_SPEC.pitch_scale = randf_range(0.7, 1.4)
		SE_HIT.play()

	await anim_pl.animation_finished
	anim_pl.play("idle")
	Melee_spite.set_layer_mask(2)
	#combo_timer.start()


func clear_bar():
	cur_combo = []
	combo_text.text = ""
	combo_text_small.text = ""
	combo_text_mid.text = ""
	
	var children = Bar.get_children()
	for c in children:
		#remove_child(c)
		c.queue_free()

	combo_timer.stop()
	clean_timer_var = true
	magic = false


func use_combo(show_combo : bool):
	if show_combo == true:
		input_able = false
		cur_combo = []
		Combo_sp.visible = true
		Melee_spite.visible = false

	else:
		#await anim_pl.animation_finished
		clear_bar()
		input_able = true
		Combo_sp.visible = false
		Melee_spite.visible = true
		anim_pl.play("idle")
		refresh_combo()


func refresh_combo():
	di_dmg = clamp(di_dmg +1, 1, 10)
	di_2_dmg = clamp(di_2_dmg +1, 1, 10)
	finger_beam_dmg = clamp(finger_beam_dmg +1, 1, 10)
	coun_atk_dmg = clamp(coun_atk_dmg +1, 1, 5)
	uppercut_dmg = clamp(uppercut_dmg +1, 1, 5)
	right_int_dmg = clamp(right_int_dmg +1, 1, 5)
	left_ext_dmg = clamp(left_ext_dmg +1, 1, 5)
	dir_dmg = clamp(dir_dmg +1, 1, 5)
	slap_dmg = clamp(slap_dmg -1, 1, 8)
	ball_dmg = clamp(ball_dmg +1, 1, 10)



func show_combo_list():
	canvas_layer_2.visible = true

func hide_combo_list():
	canvas_layer_2.visible = false
