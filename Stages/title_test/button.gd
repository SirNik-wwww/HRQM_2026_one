extends Button

var PL_FILE_PATH = "user://Godot_MINI_save"
var FILE_PATH = "res://Stages/Zero_point_one/enemies/save_test"


func _on_pressed() -> void:
	var k_dic = {
		k1 = 10,
		k2 = 10,
		k3 =10
		}

	var jsonString = JSON.stringify(k_dic)

	var jsonFile = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	jsonFile.store_line(jsonString)
	jsonFile.close()
	
	#var file = FileAccess.open(FILE_PATH, FileAccess.WRITE_READ)
	##file.open(FILE_PATH, FileAccess.WRITE_READ)
	#file.store_var(null)
	#file.close

	var file_pl = FileAccess.open(PL_FILE_PATH, FileAccess.WRITE_READ)
	#file.open(FILE_PATH, FileAccess.WRITE_READ)
	file_pl.store_var(null)
	file_pl.close

	get_tree().change_scene_to_file("res://Stages/Zero_point_one/zero_point_one_level.tscn")
