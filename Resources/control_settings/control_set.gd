extends Control

const INPUT_BUTT_TSCN = preload("uid://cw537x2u4fpbc")
const LABEL_IN_SETTINGS = preload("uid://drrvc4dmuu42d")
const SOME_CHECKBOXXES_IN_SETTINGS = preload("uid://cu5lpg3fnbt4g")

#@onready var input_butt_tscn = "res://Resources/control_settings/settings_button.tscn"
@onready var list_of_actions: VBoxContainer = $VBoxContainer/for_buttons/ScrollContainer/list_of_actions


var is_remapping = false
var action_to_remap = null
var remapping_buttion = null

#https://youtu.be/4gLB8vxfD_c?si=RW1s-yLyS6iblq2m

var input_act_dic = {
	"+w" : tr("Key_Foward"),
	"+a" : tr("Key_Left"),
	"+s" : tr("Key_Back"),
	"+d" : tr("Key_Right"),
	"_run" : tr("Key_Run"),
	"_crouch" : tr("Key_Crouch"),
	"_jump" : tr("Key_Jump"),
	"+mouse_left" : tr("Key_Shoot"),
	"+mouse_right" : tr("Key_Alt_Shoot"),
	"+mouse_mid" : tr("Key_Middle_hit"),
	"_menu" : tr("Key_Menu"),
	"_full_screen" : tr("Key_Fullscreen"),
	"-quit" : tr("Key_Alt_F4"),
	"-restart_debug" : tr("Key_Restart_all"),
	"+restart" : tr("Key_Restart_check"),
	"-show_mouse" : tr("Key_Show_Cursor"),

## index 15
	"-save_game" : tr("Key_save_game"),
	"-load_game" : tr("Key_load_game"),
	"-quick_debug(1)" : tr("Key_Inf_Jump"),
	"-debug_f" : tr("Key_show_fps"),
	"-inf_hp" : tr("Key_inf_hp"),
	"-inf_dmg" : tr("Key_inf_dmg"),
	"-quick_debug(2)" : tr("Key_idk_1"),
	"-debug_q" : tr("Key_idk_2"),
}


func _ready() -> void:
	get_tree().call_group("hide_after_enter_control_set", "hide_after_enter_control_set")
	get_tree().call_group("Coun_atk", "hide_combo_list")
	_load_keybin_from_set()
	_create_action_list()


func _load_keybin_from_set():
	var keybin = ConfigFileHandler.load_keybin()
	for action in keybin.keys():
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, keybin[action])


func _create_action_list():
	#InputMap.load_from_project_settings()
	for iction in list_of_actions.get_children():
		iction.queue_free()

	for action in input_act_dic:
		var butt = INPUT_BUTT_TSCN.instantiate()
		var action_lebel = butt.find_child("ActionLabel")
		var input_butt_also_lebel = butt.find_child("Button_itself")
		
		action_lebel.text = input_act_dic[action]
		
		var events  = InputMap.action_get_events(action)
		if events.size() > 0:
			input_butt_also_lebel.text = events[0].as_text().trim_suffix(" (Physical)")
			input_butt_also_lebel.text = events[0].as_text().trim_suffix(" - Physical")
		else :
			input_butt_also_lebel.text = ""

		list_of_actions.add_child(butt)

		butt.find_child("Button_itself").pressed.connect(_on_input_bott_pressed.bind(butt, action))


	var label_in_set = LABEL_IN_SETTINGS.instantiate()
	list_of_actions.add_child(label_in_set)
	list_of_actions.move_child(label_in_set, 15)

	var checkboxxes = SOME_CHECKBOXXES_IN_SETTINGS.instantiate()
	list_of_actions.add_child(checkboxxes)
	list_of_actions.move_child(checkboxxes, 0)

func _on_input_bott_pressed(butt, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_buttion = butt
		butt.find_child("Button_itself").text = tr("Key_bind")

func _input(event: InputEvent) -> void:
	if is_remapping:
		if event is InputEventKey or (event is InputEventMouseButton and event.is_pressed()):
			InputMap.action_erase_events(action_to_remap)
			# в следующем туториале DashNothing код выглядит по другому в этом месте
			InputMap.action_add_event(action_to_remap, event)
			ConfigFileHandler.save_keybin(action_to_remap, event)
			_update_action_list(remapping_buttion, event)

			is_remapping = false
			action_to_remap = null
			remapping_buttion = null

			accept_event()


func _update_action_list(butt, event):
	butt.find_child("Button_itself").text = event.as_text().trim_suffix(" (Physical)")
	butt.find_child("Button_itself").text = event.as_text().trim_suffix(" - Physical")



func _on_button_reset_pressed() -> void:
	InputMap.load_from_project_settings()
	for action in input_act_dic:
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			ConfigFileHandler.save_keybin(action, events[0])
	_create_action_list()
	await get_tree().create_timer(0.05).timeout
	var debug_label = list_of_actions.get_child(1)
	list_of_actions.move_child(debug_label, 15)
	


func _on_button_done_pressed() -> void:
	get_tree().call_group("show_after_quit_control_set", "show_after_quit_control_set")
	get_tree().call_group("Coun_atk", "show_combo_list")
	queue_free()
