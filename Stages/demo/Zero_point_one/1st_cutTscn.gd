extends Area3D

@onready var CTSCN_CAM: Camera3D = $"../Camera3D"
@onready var PLAYER: Player = $"../../../Simple_player"
@onready var dialogue_balloon: CanvasLayer = $"../DialogueBalloon"
@onready var cut_tscn_1: Node3D = $".."
@onready var Marisa: Sprite3D = $"../Sprite3D"
@onready var START_MARKER: Marker3D = $"../start_marker"


func _on_area_entered(_area: Area3D) -> void:
	CTSCN_CAM.global_position = PLAYER.CAMERA_CONTROLLER.global_position
	CTSCN_CAM.rotation = PLAYER.CAMERA_CONTROLLER.rotation
	PLAYER.process_mode = Node.PROCESS_MODE_DISABLED
	switch(true)

	#CTSCN_CAM.position = lerp(CTSCN_CAM.position,START_MARKER.position, 3)
	#var cam_terminal = Vector3()
	get_tree().create_tween().tween_property(CTSCN_CAM, "position", START_MARKER.position, 0.2)
	dialogue_balloon.show_line()
	$"../AudioStreamPlayer".play()


func end_ctscn():
	var New_Marisa_pos =  Vector3(Marisa.position.x, Marisa.position.y -10, Marisa.position.z)
	get_tree().create_tween().tween_property(Marisa, "position", New_Marisa_pos, 0.4)
	get_tree().create_tween().tween_property(CTSCN_CAM, "global_position", PLAYER.CAMERA_CONTROLLER.global_position, 0.2)
	dialogue_balloon.visible = false
	await get_tree().create_timer(0.5).timeout
	
	PLAYER.process_mode = Node.PROCESS_MODE_INHERIT
	switch(false)
	cut_tscn_1.queue_free()


func switch(active: bool):
	PLAYER.CAMERA_CONTROLLER.current = !active
	CTSCN_CAM.current = active
	#PLAYER.input_able = !active
	PLAYER.velocity = Vector3(0,0,0)
	PLAYER.visible = !active
	hide_d_balloon(!active)


func hide_d_balloon(hide : bool = true):
	dialogue_balloon.set_process_input(!hide)
	dialogue_balloon.visible = !hide
