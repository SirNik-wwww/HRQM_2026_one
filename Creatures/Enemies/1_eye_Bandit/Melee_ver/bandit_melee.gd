class_name Bandit_Melee extends Enemy_starter_pack

@export var ATK_SHAPE_CAST : ShapeCast3D

var can_move : bool = true


func _ready() -> void:
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
	DEFAULT_ST.Trans.emit("WarningBandit_MState")


func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()



#func update_velocity():
	#set_target_pos(PLAYER.position)
	#move_and_slide()



func _on_area_3d_for_jump_body_entered(_body: Node3D) -> void:
	if is_on_floor() == true and can_jump == true:
		$Area3D_for_jump/Jump_Timer.start()
		can_jump = !can_jump
		velocity.y += jump_vel





func _on_jump_timer_timeout() -> void:
	can_jump = true
