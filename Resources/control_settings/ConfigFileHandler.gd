extends Node

var config = ConfigFile.new()

const SETTING_FILE_PATH = "user://Godot_Control_save_SN.ini"


func _ready() -> void:
	if !FileAccess.file_exists(SETTING_FILE_PATH):
		config.set_value("keybin", "+w", "W")
		config.set_value("keybin", "+a", "A")
		config.set_value("keybin", "+s", "S")
		config.set_value("keybin", "+d", "D")
		config.set_value("keybin", "_run", "shift")
		config.set_value("keybin", "_crouch", "Ctrl")
		config.set_value("keybin", "_jump", "Space")
		config.set_value("keybin", "+mouse_left", "mouse_1")
		config.set_value("keybin", "+mouse_right", "mouse_2")
		config.set_value("keybin", "+mouse_mid", "mouse_3")
		config.set_value("keybin", "_menu", "Escape")
		config.set_value("keybin", "_full_screen", "F4")
		config.set_value("keybin", "-quit", "Period")
		#config.set_value("keybin", "-restart_debug", "")
		config.set_value("keybin", "+restart", "R")
		config.set_value("keybin", "-show_mouse", "Comma")

		config.set_value("keybin", "-save_game", "2")
		config.set_value("keybin", "-load_game", "3")
		config.set_value("keybin", "-quick_debug(1)", "1")
		config.set_value("keybin", "-debug_f", "F")
		config.set_value("keybin", "-inf_hp", "H")
		config.set_value("keybin", "-inf_dmg", "G")
		config.set_value("keybin", "-quick_debug(2)", "2")
		config.set_value("keybin", "-debug_q", "Q")

		config.set_value("video", "fullscreen", false)
		config.set_value("audio", "master_volume", 0.0)
		config.set_value("audio", "music_volume", 1.0)
		config.set_value("audio", "sfx_volume", 1.0)

		config.save(SETTING_FILE_PATH)

	else :
		config.load(SETTING_FILE_PATH)


func save_video_set(key : String, value):
	config.set_value("video", key, value)
	config.save(SETTING_FILE_PATH)

func load_video_set():
	var vid_set = {}
	for key in config.get_section_keys("video"):
		vid_set[key] = config.get_value("video", key)
	return vid_set


func save_audio_set(key : String, value):
	config.set_value("audio", key, value)
	config.save(SETTING_FILE_PATH)



func load_audio_set():
	var audio_set = {}
	for key in config.get_section_keys("audio"):
		audio_set[key] = config.get_value("audio", key)
	return audio_set



func save_keybin(act : StringName, event : InputEvent):
	var event_str
	if event is InputEventKey:
		event_str = OS.get_keycode_string(event.physical_keycode)
	elif event is InputEventMouseButton:
		event_str = "mouse_" + str(event.button_index)

	config.set_value("keybin", act, event_str)
	config.save(SETTING_FILE_PATH)


func load_keybin():
	var keybin = {}
	var keys = config.get_section_keys("keybin")
	for key in keys:
		var input_event
		var event_str = config.get_value("keybin", key)

		if event_str.contains("mouse_"):
			input_event = InputEventMouseButton.new()
			input_event.button_index = int(event_str.split("_")[1])
		else:
			input_event = InputEventKey.new()
			input_event.keycode = OS.find_keycode_from_string(event_str)

		keybin[key] = input_event
	return keybin
