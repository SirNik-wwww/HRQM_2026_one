extends CharacterBody3D


@export var DEFAULT_ST : Node

@export var HURT_BOX : HurtBox
@export var COLLISION : CollisionShape3D
@export var H_BAR : TextureProgressBar
@export var ANIM_PL : AnimatedSprite3D
@export var HEALTH_COLOR : String = "blu"

@onready var hp_label: Label = $SubViewport/ProgressBar/Label
@onready var atk_timer: Timer = $Atk_Timer

var jump_vel = 6.0
var can_jump = true
var can_move = true
var _speed = 2.0
var gravity = 12.0
var lives = 10
var max_hp : int = 10

var beatable = true
var dir
var dead : bool = false
var atk_able = true

var PLAYER : Player


func _ready() -> void:
	PLAYER = Globus.player
	hp_label.text = str(lives) + "/" + str(max_hp) # меняет текст в лейбле


func take_damage(how_much = 1, is_it_damage := true):
	if is_it_damage == true:
		if beatable == true:
			beatable = !beatable
			lives -= how_much

			PLAYER.PIG_COL.add_pigment(HEALTH_COLOR, 1) # добавляет пигмент

			H_BAR.value = lives # меняет значение в прогрессбаре на то, что сейчас
			hp_label.text = str(lives) + "/" + str(max_hp) # меняет текст в лейбле

			ANIM_PL.modulate = Color(1, 0, 0)
			if lives <= 0:
				die()
			else:
				await get_tree().create_timer(0.1).timeout
				ANIM_PL.modulate = Color(1, 1, 1)
				beatable = !beatable
	else:
		lives += how_much
		if lives > max_hp:
			lives = max_hp



func die():
	if dead != true:
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
		COLLISION.disabled = true

		ANIM_PL.play("die")
		await get_tree().create_timer(1).timeout
		get_parent().remove_child(self)
		queue_free()



func turn_on():
	DEFAULT_ST.Trans.emit("ChaseKirt_2State")


func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()


#
#func update_velocity():
	##set_target_pos(PLAYER.position)






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


func _on_atk_timer_timeout() -> void:
	atk_able = true


func _on_area_3d_for_jump_body_entered(body: Node3D) -> void:
	if can_jump == true:
		can_jump = !can_jump
		velocity.y += jump_vel
		$Area3D_for_jump/Jump_Timer.start()


func _on_jump_timer_timeout() -> void:
	can_jump = true
