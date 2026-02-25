extends Node3D

@onready var g_m_e: Node = $Global_Music_etc

@onready var button_sound: AudioStreamPlayer = $ButtonSound
const CONTROL_SET = preload("uid://s8231in8rp4v")


var sound_main: HSlider 
var sound_ost: HSlider 
var sound_sfx: HSlider

var main_lebel: RichTextLabel 
var ost_lebel: RichTextLabel
var sfx_lebel: RichTextLabel



@export var stage_selection: Control
@export var control_set: Control
@export var control_self: Control


var bgm_pl : AudioStreamPlayer


func _ready() -> void:
	bgm_pl = g_m_e.bgm
	bgm_pl.volume_db = -6.0
	bgm_pl.play()





func _on_button_setting_pressed() -> void:
	#control_set.visible = !control_set.visible
	add_child(CONTROL_SET.instantiate())
	control_self.visible = false
	button_sound.play()


func _on_button_exit_pressed() -> void:
	get_tree().quit()
	



func _on_button_start_pressed() -> void:
	control_self.visible = !control_self.visible
	stage_selection.visible = !stage_selection.visible
	button_sound.play()


func show_after_quit_control_set():
	control_self.visible = true
