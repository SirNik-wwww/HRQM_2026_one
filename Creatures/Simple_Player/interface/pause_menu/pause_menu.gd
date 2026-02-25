extends Control

@export var OST : AudioStreamPlayer
@export var canvas_layer: CanvasLayer
@export var control_real: Control

const COOL_TITLE = "uid://cq03whbwg4xiw"
const CONTROL_SET = preload("uid://s8231in8rp4v")



var ost_is_playing = false
var is_paused = false
var PLAYER : Player

func _ready() -> void:
	set_process_mode(Node.PROCESS_MODE_ALWAYS)
	if Globus.player != null:
		PLAYER = Globus.player


func _input(_event: InputEvent) -> void:
	if Globus.is_on_stage == true:
		if Input.is_action_just_pressed("_menu") and PLAYER.is_dead == false:
			pausing_func()

		elif Input.is_action_just_pressed("-restart_debug") and is_paused == true:
			pausing_func()

		elif Input.is_action_just_pressed("_menu") and PLAYER.is_dead == true:
			get_tree().reload_current_scene()



func pausing_func():
	if is_paused == false:
		get_tree().paused = true
		canvas_layer.show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().call_group("Coun_atk", "show_combo_list")
	else:
		get_tree().paused = false
		canvas_layer.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_tree().call_group("Coun_atk", "hide_combo_list")

	is_paused = !is_paused



########################################################
##_______________ КНОПКИ _____________________________##
func _on_sound_pressed() -> void: # звук
	$Container/Control3/VBoxContainer/ColorRect/MarginContainer/VBoxContainer/MarginContainer/Sound/AudioStreamPlayer.play()

func _on_continue_pressed() -> void: # продолжение
	pausing_func()

func _on_restart_pressed() -> void: # Рестарт
	pausing_func()
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void: # Выход
	get_tree().quit()


func _on_control_pressed() -> void:
	var cst = CONTROL_SET.instantiate()
	visible = false

	control_real.add_child(cst)


func _on_quit_2_pressed() -> void:
	pausing_func()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Globus.is_on_stage = false
	get_tree().change_scene_to_file(COOL_TITLE)
