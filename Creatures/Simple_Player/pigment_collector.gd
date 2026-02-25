extends Node3D

@onready var red_bar: TextureProgressBar = $SubViewport/Control/HBoxContainer/Red_Bar
@onready var blue_bar: TextureProgressBar = $SubViewport/Control/HBoxContainer/Blue_Bar
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

@onready var red_label: Label = $SubViewport/Control/HBoxContainer/Red_Bar/Red_Label
@onready var blue_label: Label = $SubViewport/Control/HBoxContainer/Blue_Bar/Blue_Label




var red_pig : int = 0
var blu_pig : int = 0
var pur_pig : int = 0
# red, blue and purple pigments

func _ready() -> void:
	red_label.text = str(red_pig) + "/20"
	blue_label.text = str(blu_pig) + "/20"


func add_pigment(color : String, how_much : int):
	if color == "red":
		red_pig += how_much
		red_label.text = str(red_pig) + "/20"
	if color == "blu":
		blu_pig += how_much
		blue_label.text = str(blu_pig) + "/20"
	if color == "pur":
		pur_pig += how_much
	if color == "null":
		red_pig = 0
		red_label.text = str(red_pig) + "/20"
		blu_pig = 0
		blue_label.text = str(blu_pig) + "/20"


	if red_pig >= 20:
		#print("red_overflow")
		#audio.play()
		red_pig = 0
		Globus.player.PL_HP.take_damage(1, false)
		red_label.text = str(red_pig) + "/20"


	if blu_pig >= 20:
		#print("blue_overflow")
		#audio.play()
		blu_pig = 0
		Globus.player.PL_HP.add_shield(1)
		blue_label.text = str(blu_pig) + "/20"

	red_bar.value = red_pig
	blue_bar.value = blu_pig
