extends Control

@onready var v_norm: Control = $"V-Norm"
@onready var v_ultra_uzko: Control = $"V-Ultra_uzko"
@onready var v_doom: Control = $"V-Doom"
@onready var v_damb: Control = $"V-damb"
@onready var v_cool: Control = $"V-Cool"
@onready var v_bar: Control = $"V-Bar"
@onready var v_haha: Control = $"V-haha"

var mode = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("+q"):
		v_norm.visible = false
		v_ultra_uzko.visible = false
		v_doom.visible = false
		v_damb.visible = false
		v_cool.visible = false
		v_bar.visible = false
		v_haha.visible = false
	
		mode = randi_range(0, 7)

		#if mode == 0:
			#v_norm.visible = false
			#v_ultra_uzko.visible = false
			#v_doom.visible = false
			#v_damb.visible = false
			#v_cool.visible = false
			#v_bar.visible = false
		
		#if mode == 1:
			#v_norm.visible = true
		#
		#if mode == 2:
			#v_ultra_uzko.visible = true
		#
		#if mode == 3:
			#v_doom.visible = true
		#
		#if mode == 4:
			#v_damb.visible = true
		#
		#if mode == 5:
			#v_cool.visible = true
		#
		#if mode == 6:
			#v_bar.visible = true

	if event.is_action_pressed("+1"):
		v_norm.visible = false
		v_ultra_uzko.visible = false
		v_doom.visible = false
		v_damb.visible = false
		v_cool.visible = false
		v_bar.visible = false
		v_haha.visible = false

		mode += 1


func _process(delta: float) -> void:
	if mode == 0:
			v_norm.visible = false
			v_ultra_uzko.visible = false
			v_doom.visible = false
			v_damb.visible = false
			v_cool.visible = false
			v_bar.visible = false
		
	if mode == 1:
		v_norm.visible = true
	
	if mode == 2:
		v_ultra_uzko.visible = true
	
	if mode == 3:
		v_doom.visible = true
	
	if mode == 4:
		v_damb.visible = true
		
	if mode == 5:
		v_cool.visible = true
		
	if mode == 6:
		v_bar.visible = true
	
	if mode == 7:
		v_haha.visible = true
		mode = -1
