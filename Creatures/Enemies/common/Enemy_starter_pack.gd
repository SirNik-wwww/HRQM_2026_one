extends CharacterBody3D
class_name Enemy_starter_pack



@export var DEFAULT_ST : Node

@export var HURT_BOX : HurtBox
@export var COLLISION : CollisionShape3D
@export var H_BAR : TextureProgressBar
@export var SPRITE : Sprite3D
@export var ANIM_PL : AnimationPlayer
@export var HEALTH_COLOR : String = "red"

@export var hp_label: Label
@export var pain: AudioStreamPlayer3D


var dying_sounds : Array

@export var speed = 3.0
@export var jump_vel = 6.0

@export var lives = 10
@export var max_hp : int = 10

var can_jump : bool = true

var gravity = 12.0

var beatable = true
var can_atk : bool = true
var dir
var dead : bool = false

var PLAYER : Player

var active : bool = false




func custom_ready():

	add_to_group("Enemy")
	add_to_group("Needs_be_save")
	PLAYER = Globus.player
	H_BAR.value = lives
	hp_label.text = str(lives) + "/" + str(max_hp) # меняет текст в лейбле
	#await get_tree().create_timer(1.0).timeout
	#print(get_groups())



func take_damage(how_much = 1, is_it_damage := true):
	
	#await get_tree().create_timer(1.0).timeout
	#print(get_groups())
	if active == false:
		var groups = get_groups()
		if groups.size() > 1:
			var cur_room = groups[2]
			var room_name = "Start_enc_area" + cur_room
			get_tree().call_group(room_name, "extra_start")
	if how_much <= 0:
		how_much = 0
	if is_it_damage == true:
		if beatable == true:
			beatable = !beatable
			lives -= how_much

			PLAYER.PIG_COL.add_pigment(HEALTH_COLOR, 1) # добавляет пигмент

			H_BAR.value = lives # меняет значение в прогрессбаре на то, что сейчас
			hp_label.text = str(lives) + "/" + str(max_hp) # меняет текст в лейбле

			SPRITE.modulate = Color(1, 0, 0)
			if lives <= 0:
				die()
			else:
				beatable = !beatable
				await get_tree().create_timer(0.1).timeout
				SPRITE.modulate = Color(1, 1, 1)
	else:
		lives += how_much
		if lives > max_hp:
			lives = max_hp


func die():
	if dead != true:
		can_atk = false
		beatable = false
		var groups = get_groups()
		for group in groups:
			remove_from_group(group)
		velocity = Vector3.ZERO
		velocity.y += 3

		dead = true

		Globus.enemy_died.emit()

		get_parent().remove_child(HURT_BOX)
		HURT_BOX.queue_free()
		H_BAR.visible = false
		hp_label.visible = false
		
		if get_tree().has_method("additional_death_effect"):
			get_tree().additional_death_effect()
		#$MeshInstance3D.visible = false
		#COLLISION.disabled = true
		set_collision_layer_value(3, false)
		set_collision_mask_value(2, false)
		set_collision_mask_value(3, false)

		ANIM_PL.play("die")
		var rnd_index = randi_range(0, dying_sounds.size() -1)
		#print(dying_sounds.size())
		var selected_sound = dying_sounds[rnd_index]
		pain.stream = selected_sound
		pain.pitch_scale = randf_range(0.9, 1.1)
		pain.play()
		await get_tree().create_timer(1).timeout
		get_parent().remove_child(self)
		queue_free()



#############################################################
##__________________ Сохранение ___________________________##
func on_save_game(saved_data : Array[SavedData]):
	if dead == true:
		return
	var my_data = SavedData.new()
	my_data.pos = global_position
	my_data.scene_path = scene_file_path
	my_data.cur_hp = lives
	my_data.groups = get_groups()

	saved_data.append(my_data) # переделывает в аррей????

func on_before_load():
	get_parent().remove_child(self)
	queue_free()

func on_load_game(saved_data : SavedData):
	global_position = saved_data.pos
	lives = saved_data.cur_hp
	for group in saved_data.groups:
		add_to_group(group)
#############################################################
#############################################################
