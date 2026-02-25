extends Enemy_starter_pack
class_name Bandit_ak

@export var nav_agent : NavigationAgent3D
@export var ATK_SHAPE_CAST : ShapeCast3D

@onready var recalc_timer: Timer = $RecalcTimer

var can_move : bool = false




func _ready() -> void:
	visible = false
	beatable = false
	
	speed = speed * 1.5
	max_hp = 50
	$SubViewport/ProgressBar.value = max_hp
	lives = 50
	recalc_timer.timeout.connect(_on_time_out)
	#print("I HERE")
	#await get_tree().create_timer(0.1).timeout
	custom_ready()
	dying_sounds = [
	preload("res://Sound/SE/voices/крехтение - 3.wav"),
	preload("res://Sound/SE/voices/крехтение - 6 (почти крик).wav"),
	preload("res://Sound/SE/voices/крехтение - 7 (бля).wav")
	]


func additional_death_effect():
	print("TEST 222211212")
	$MeshInstance3D.visible = false


func turn_on():
	active = true
	DEFAULT_ST.Trans.emit("WarningBandit_AkState")


func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y -= gravity * delta
	var _dir = Globus.player.global_position - global_position



#############################################################################
##_______________________ передвижение ____________________________________##

	var next_path_pos = nav_agent.get_next_path_position()
#
	if can_move == true:
		if _dir.length() >= 11:
			velocity.x = global_position.direction_to(next_path_pos).x * speed
			velocity.z = global_position.direction_to(next_path_pos).z * speed

		if 9 < _dir.length() and _dir.length() < 11:
			velocity.x = 0
			velocity.z = 0

		if _dir.length() <= 9:
			##var away_distance
			var dir_away = (global_position - PLAYER.global_position).normalized()
			var away_pos = global_position + dir_away
			set_target_pos(away_pos)
			next_path_pos = nav_agent.get_next_path_position()
			velocity.x = global_position.direction_to(next_path_pos).x * speed
			velocity.z = global_position.direction_to(next_path_pos).z * speed

	move_and_slide()



func actor_setup() -> void:
	await get_tree().physics_frame
	set_target_pos(PLAYER.position)


func set_target_pos(terget_pos : Vector3) -> void:
	nav_agent.target_position = terget_pos


func _on_time_out() -> void:
	set_target_pos(PLAYER.position)
#func update_velocity():
	#set_target_pos(PLAYER.position)
	#move_and_slide()
