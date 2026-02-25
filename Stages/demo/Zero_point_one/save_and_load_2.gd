extends Node


@export var new_home: Node3D
@export var PLAYER : Player

const FILE_PATH := "user://Godot_MINI_save_2.tres"



func _ready() -> void:
	Globus.check_point = false

	save_game()


func save_game():
	var saved_game : SaveGame = SaveGame.new()

	saved_game.pl_hp = PLAYER.PL_HP.pl_lives
	saved_game.pl_pos = PLAYER.global_position
	saved_game.pl_was_crouching = PLAYER.crouch_speed_state

	var saved_data_1 : Array[SavedData] = []
	get_tree().call_group("Needs_be_save", "on_save_game", saved_data_1)
	saved_game.saved_data = saved_data_1

	ResourceSaver.save(saved_game, FILE_PATH)

func load_game():
	if ResourceLoader.exists(FILE_PATH):
		var saved_game : SaveGame = load(FILE_PATH) as SaveGame

		PLAYER.global_position = saved_game.pl_pos
		PLAYER.PL_HP.pl_lives = 6
		if saved_game.pl_was_crouching == true:
			PLAYER.position.y += 3
		#PLAYER.PL_HP.take_damage(90, false)
		PLAYER.PL_HP.check_hp()
		PLAYER.PIG_COL.add_pigment("null", 0)
		PLAYER.NUNCH.clear_bar()

		PLAYER.run_speed_func()
		PLAYER.crouching(false)
		PLAYER.crouch_speed_state = false
		PLAYER.crouch_speed_func()

		get_tree().call_group("Needs_be_save", "on_before_load")
		await get_tree().create_timer(0.1).timeout
		#var enemies = get_tree().get_nodes_in_group("Start_enc_area")
		#for area in enc_areas:
			#area.actived = false
		get_tree().call_group("Start_enc_area", "reset_room")

		for item in saved_game.saved_data: # я понятия не имею что за item (25.06.29 - теперь имею)
			var scene = load(item.scene_path) as PackedScene
			var restored_node = scene.instantiate()
			#if restored_node != null:
			new_home.add_child(restored_node)

			if restored_node.has_method("on_load_game"):
				restored_node.on_load_game(item)



func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("-save_game"):
		save_game()
		print("save")

	if Input.is_action_just_pressed("+restart"):
		if Globus.check_point == false:
			get_tree().reload_current_scene()
		else:
			load_game()
		print("load")
