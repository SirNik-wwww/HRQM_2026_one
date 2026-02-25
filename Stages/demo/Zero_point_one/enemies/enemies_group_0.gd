extends Node3D

const FILE_PATH = "res://Stages/Zero_point_one/enemies/save_test"


#@onready var kirt: Kirt = $kirt
#@onready var kirt_2: Kirt = $kirt2
#@onready var kirt_3: Kirt = $kirt3


#func _ready() -> void:
	#var jsonFile = FileAccess.open(FILE_PATH, FileAccess.READ)
	#if jsonFile != null:
		#load_enemy_data()

#
#
#func save_enemy_data():
	#var kirt_lives
	#var kirt_lives_2
	#var kirt_lives_3
#
	#if kirt != null:
		#kirt_lives = kirt.lives
	#else:
		#kirt_lives = 0
#
	#if kirt_2 != null:
		#kirt_lives_2 = kirt_2.lives
	#else:
		#kirt_lives_2 = 0
#
	#if kirt_3 != null:
		#kirt_lives_3 = kirt_3.lives
	#else:
		#kirt_lives_3 = 0
#
#
	#var k_dic = {
		#k1 = kirt_lives,
		#k2 = kirt_lives_2,
		#k3 = kirt_lives_3
		#}
#
	#var jsonString = JSON.stringify(k_dic)
#
	#var jsonFile = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	#jsonFile.store_line(jsonString)
	#jsonFile.close()
#
#
#func load_enemy_data():
	#var jsonFile = FileAccess.open(FILE_PATH, FileAccess.READ)
	#var jsonString = jsonFile.get_as_text()
	#jsonFile.close()
#
	## из json текста в словать
	#var k_dic = JSON.parse_string(jsonString)
#
	#if k_dic.k1 != null:
		#kirt.lives = k_dic.k1
	#else:
		#kirt.queue_free()
#
	#if k_dic.k2 != null:
		#kirt_2.lives = k_dic.k2
	#else:
		#kirt_2.queue_free()
#
	#if k_dic.k3 != null:
		#kirt_3.lives = k_dic.k3
	#else:
		#kirt_3.queue_free()
