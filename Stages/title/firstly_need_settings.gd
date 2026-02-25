extends MarginContainer

@export var sound_main: HSlider 
@export var sound_ost: HSlider 
@export var sound_sfx: HSlider

@export var main_lebel: RichTextLabel 
@export var ost_lebel: RichTextLabel
@export var sfx_lebel: RichTextLabel

@export var fullscreen_box: CheckBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var vid_set = ConfigFileHandler.load_video_set()
	fullscreen_box.button_pressed = vid_set.fullscreen

	var audio_set = ConfigFileHandler.load_audio_set()

	sound_main.value = max(audio_set.master_volume + 0.01, 0.0)
	sound_ost.value = max(audio_set.music_volume + 0.01, 0.0)
	sound_sfx.value = max(audio_set.sfx_volume + 0.01, 0.0)

	if sound_main.value != 1.0:
		sound_main.value -= 0.01
	if sound_ost.value != 1.0:
		sound_ost.value -= 0.01
	if sound_sfx.value != 1.0:
		sound_sfx.value -= 0.01
# по какой-то причине звук не хочет устанавливаться на 0.0 через код, поэтому тут нужет такой костыль

	sound_main.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	sound_sfx.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	sound_ost.value = db_to_linear(AudioServer.get_bus_volume_db(2))


func _on_sound_main_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))



func _on_sound_ost_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
	


func _on_sound_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(value))



func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	ConfigFileHandler.save_video_set("fullscreen", toggled_on)
	


func _on_sound_main_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHandler.save_audio_set("master_volume", sound_main.value)


func _on_sound_ost_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHandler.save_audio_set("music_volume", sound_ost.value)


func _on_sound_sfx_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHandler.save_audio_set("sfx_volume", sound_sfx.value)


func hide_after_enter_control_set():
	visible = false

func show_after_quit_control_set():
	visible = true
