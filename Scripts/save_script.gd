extends Node

const FILE_PATH := "user://Godot_save_SN"

func save_pl_progress():
	var player_position = {
		"x": round(Globus.player.position.x),
		"y": round(Globus.player.position.y),
		"z": round(Globus.player.position.z)
	}

	var jsonString = JSON.stringify(player_position)

	var jsonFile = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	jsonFile.store_line(jsonString)
	jsonFile.close()

	print("save")

func load_pl_progress():
	var jsonFile = FileAccess.open(FILE_PATH, FileAccess.READ)
	var jsonString = jsonFile.get_as_text()
	jsonFile.close()

	# из json текста в словать
	var player_position = JSON.parse_string(jsonString)
	
	Globus.player.position.x = player_position.x
	Globus.player.position.y = player_position.y
	Globus.player.position.z = player_position.z

	print("load")
