extends Area3D

@export var save_load : Node

#const FILE_PATH := "user://Godot_MINI_save"

#func _ready() -> void:
	#$"../../Enemies".load_enemy_data()

func _on_body_entered(_body: Node3D) -> void:
	#print("He is here")
	Globus.check_point = true
	
	$AudioStreamPlayer.play()
	save_load.save_game()
	#save_pl_progress()
	$CollisionShape3D.queue_free()
	await $AudioStreamPlayer.finished
	get_parent().remove_child(self)
	queue_free()


#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("-quick_debug"):
		#load_pl_progress()

#
#func save_pl_progress():
	#$"../../Enemies/group_0".save_enemy_data()
#
	#var player_position = {
		#"x": round(Globus.player.position.x),
		#"y": round(Globus.player.position.y),
		#"z": round(Globus.player.position.z)
	#}
#
	#var jsonString = JSON.stringify(player_position)
#
	#var jsonFile = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	#jsonFile.store_line(jsonString)
	#jsonFile.close()
#
	#print("save")
#
#func load_pl_progress():
	#var jsonFile = FileAccess.open(FILE_PATH, FileAccess.READ)
	#var jsonString = jsonFile.get_as_text()
	#jsonFile.close()
#
	## из json текста в словать
	#var player_position = JSON.parse_string(jsonString)
	#
	#if player_position != null:
		#Globus.player.position.x = player_position.x
		#Globus.player.position.y = player_position.y
		#Globus.player.position.z = player_position.z
#
	#print("load")
