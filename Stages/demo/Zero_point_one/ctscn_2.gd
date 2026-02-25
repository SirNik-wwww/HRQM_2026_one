extends Area3D

@onready var CTSCN_CAM: Camera3D = $"../Camera3D"
@onready var PLAYER: Player = $"../../../Simple_player"
@onready var dialogue_balloon: CanvasLayer = $"../DialogueBalloon"
@onready var cut_tscn_2: Node3D = $".."

func _on_area_entered(area: Area3D) -> void:
	switch(true)


func end_ctscn():
	switch(false)
	cut_tscn_2.queue_free()


func switch(active: bool):
	PLAYER.CAMERA_CONTROLLER.current = !active
	CTSCN_CAM.current = active
	PLAYER.input_able = !active
	PLAYER.velocity = Vector3(0,0,0)
	#PLAYER.INTERFACE.visible = false
	PLAYER.visible = !active
	dialogue_balloon.set_process_input(active)
	dialogue_balloon.visible = active
	if active == true:
		dialogue_balloon.show_line()
