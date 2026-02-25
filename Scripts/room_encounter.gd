extends Area3D
class_name room_encounter

@export var next_door: StaticBody3D
@export var backdoor: StaticBody3D
@export var alt_backdoor: StaticBody3D

@export var audio_pl: AudioStreamPlayer
var enemies: Array
@export var enemies_node: EnemyPack
@export var group_number : String

#@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

const victory_sound = preload("res://Sound/SE/Something/796078_(CUT and PROCESSED )_claytonkb__electric-vehicle-ev-emergency-orchestra-hit.wav")
const trumpet = preload("res://Sound/test/harbour11__trumpet2 and KIZILSUNGUR alearts.wav")

var actived := false
var complited := false

var time_to_close_open := 0.4

var pos_next_door : Vector3
var pos_back_door : Vector3
var pos_back_door_2 : Vector3

func _ready() -> void:
	add_to_group("Start_enc_area")
	#add_to_group("Needs_be_save")
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_mask_value(2, true)
	enemies = enemies_node.get_children(false)
	audio_pl.stream = trumpet
	audio_pl.volume_db = -5
	var room_name = "Start_enc_area" + group_number
	self.add_to_group(room_name)
	self.connect(&"body_entered", Callable(self, "start_encounter"))
	#door_collision_shape_3d.disabled = true

	Globus.enemy_died.connect(en_check)

	for enemy in enemies:
		enemy.add_to_group(group_number)

	pos_next_door = next_door.position
	pos_back_door = backdoor.position
	pos_back_door_2 = alt_backdoor.position


func start_encounter(_body : Node3D):
	#print("ASDHUAISUFHAISUFGIASUFGA")
	if actived == false:
		audio_pl.stream = trumpet
		actived = true
		audio_pl.play()
		get_tree().call_group(group_number, "turn_on")
		var terminal_back = Vector3(pos_back_door.x, pos_back_door.y +4, pos_back_door.z)
		get_tree().create_tween().tween_property(backdoor, "position", terminal_back, time_to_close_open)
		var terminal_1 = Vector3(pos_next_door.x, pos_next_door.y +4, pos_next_door.z)
		get_tree().create_tween().tween_property(next_door, "position", terminal_1, time_to_close_open)




func reset_room():
	complited = false
	actived = false
	#var terminal_back = Vector3(pos_back_door.x, pos_back_door.y, pos_back_door.z)
	#get_tree().create_tween().tween_property(backdoor, "position", terminal_back, 0)

	#var terminal_1 = Vector3(pos_next_door.x, pos_next_door.y, pos_next_door.z)
	#get_tree().create_tween().tween_property(next_door, "position", terminal_1, 0)
	next_door.position = pos_next_door
	backdoor.position = pos_back_door
	alt_backdoor.position = pos_back_door_2
	#print("reset" + str(group_number))



func extra_start():
	if actived == false:
		backdoor = alt_backdoor
		pos_back_door = alt_backdoor.position
		start_encounter(Globus.player)


func en_check():
	if get_tree().get_nodes_in_group(group_number).size() <= 0 and complited == false:
		complited = true
		audio_pl.stream = victory_sound
		audio_pl.volume_db = -3
		audio_pl.play()

		#var terminal_back = Vector3(pos_back_door.x, pos_back_door.y, pos_back_door.z)
		#get_tree().create_tween().tween_property(backdoor, "position", terminal_back, time_to_close_open)
		#var terminal_1 = Vector3(pos_next_door.x, pos_next_door.y, pos_next_door.z)
		#get_tree().create_tween().tween_property(next_door, "position", terminal_1, time_to_close_open)
	
		get_tree().create_tween().tween_property(backdoor, "position", pos_back_door, time_to_close_open)
		get_tree().create_tween().tween_property(next_door, "position", pos_next_door, time_to_close_open)



		#var terminal_back = Vector3(backdoor.position.x, backdoor.position.y -4, backdoor.position.z)
		#get_tree().create_tween().tween_property(backdoor, "position", terminal_back, time_to_close_open)
		#var terminal_1 = Vector3(pos_next_door.x, pos_next_door.y +4, pos_next_door.z)
		#get_tree().create_tween().tween_property(next_door, "position", terminal_1, time_to_close_open)


		#collision_shape_3d.disabled = true
		#get_parent().remove_child(self)
		#print("BYEEEEEEEEEEEEEE BYE B B  BYEEEEEEEEEEEEEEEEEEEEEE")
		#queue_free()



##############################################################
###__________________ Сохранение ___________________________##
#func on_save_game(saved_data : Array[SavedData]):
	#if actived == true:
		#return
	#var my_data = SavedData.new()
	#my_data.pos = global_position
	#my_data.scene_path = scene_file_path
	#my_data.groups = get_groups()
#
	#saved_data.append(my_data) # переделывает в аррей????
#
#func on_before_load():
	#get_parent().remove_child(self)
	#queue_free()
#
#func on_load_game(saved_data : SavedData):
	#global_position = saved_data.pos
	#for group in saved_data.groups:
		#add_to_group(group)
##############################################################
##############################################################
