class_name Hog extends Enemy_starter_pack



@export var ATK_TIMER : Timer

@export var ATK_SHAPE_CAST : ShapeCast3D

var can_move : bool = true



func _ready() -> void:
	max_hp = 14
	lives = 14
	custom_ready()
	dying_sounds = [preload("uid://dj3cq7xc5cj16")]
	#SPRITE.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y
	#$Area_for_dmg.add
	ATK_SHAPE_CAST.add_exception($".")
	#ATK_SHAPE_CAST.ge





func turn_on():
	DEFAULT_ST.Trans.emit("WarningHogState")
	rotation.y = 0


func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()



func _on_area_3d_for_jump_body_entered(_body: Node3D) -> void:
	if is_on_floor() == true and can_jump == true:
		$Area3D_for_jump/Jump_Timer.start()
		can_jump = !can_jump
		velocity.y += jump_vel



func _on_jump_timer_timeout() -> void:
	can_jump = true



func _on_atk_timer_timeout() -> void:
	can_atk = true
