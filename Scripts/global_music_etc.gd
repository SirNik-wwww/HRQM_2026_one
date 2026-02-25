extends Node

@onready var pause_menu: Control = $CanvasLayer/HBoxContainer/pause_menu
@onready var bgm: AudioStreamPlayer = $AudioStreamPlayer
@onready var globus_actions: Node = $Globus_actions
@onready var save: Node = $Save

@onready var control_real: Control = $Control_real

func useless_test():
	bgm.volume_db = clamp(-90, -1, 1)
	pass


func show_after_quit_control_set():
	pause_menu.visible = true
