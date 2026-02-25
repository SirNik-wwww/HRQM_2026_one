class_name WalkPlayerState extends PlayerMovementState

var top_anim_speed = 1.8

func enter() -> void:
	if PLAYER.is_running != true:
		ANIM_2.play("walk", -1.0, 1.0)
	else:
		ANIM_2.play("run", -1.0, 1.0)

func update(_delta):
	set_anim_speed(PLAYER.velocity.length())

	if Globus.player.velocity.length() == 0.0 and PLAYER.is_on_floor():
		Trans.emit("IdlePlayerState")

	if PLAYER.velocity.length() > 0.0 and !PLAYER.is_on_floor():
		Trans.emit("FallPlayerState")
#
func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("+ctrl"):
		#Trans.emit("CrouchPlayerState")
#
	if event.is_action_pressed("_jump") and PLAYER.is_on_floor():
		Trans.emit("JumpPlayerState")
#
	if event.is_action_pressed("_run"):
		#Trans.emit("RunPlayerState")
		ANIM_2.play("run", -1.0, 1.0)
		#print("run")
	if event.is_action_released("_run"):
		ANIM_2.play("walk", -1.0, 1.0)
		#print("no run")

func set_anim_speed(spd):
	var alpha = remap(spd, 0.0, PLAYER.SPEED_DF, 0.0, 1.0)
	ANIM_2.speed_scale = lerp(0.0, top_anim_speed, alpha)
