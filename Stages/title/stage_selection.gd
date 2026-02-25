extends Control

@export var main_tscn : Control

const _1_ST_STAGE = preload("uid://dbmbomabalems")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_button_1_st_st_pressed() -> void:
	get_tree().change_scene_to_file("uid://dbmbomabalems")


func _on_button_reset_pressed() -> void:
	main_tscn.visible = true
	visible = !visible
