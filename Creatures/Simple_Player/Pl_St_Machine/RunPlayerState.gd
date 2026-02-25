class_name RunPlayerState extends PlayerMovementState

var top_anim_speed = 1.8

func enter() -> void:
	ANIM_2.play("run", -1.0, 1.0)
	#PLAYER._speed += 3
	#print("run")

func update(_delta):
	set_anim_speed(PLAYER.velocity.length())

	if Globus.player.velocity.length() == 0.0 and PLAYER.is_on_floor():
		Trans.emit("IdlePlayerState")

	#if PLAYER.velocity.length() > 0.0 and !PLAYER.is_on_floor():
		#Trans.emit("FallPlayerState")
#
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("_crouch") or event.is_action_released("_run"):
		Trans.emit("WalkPlayerState")
#
	if event.is_action_pressed("_jump"):
		Trans.emit("JumpPlayerState")
#
	#if event.is_action_pressed("+shift"):
		#Trans.emit("RunPlayerState")

func set_anim_speed(spd):
	var alpha = remap(spd, 0.0, PLAYER.SPEED_DF, 0.0, 1.0)
	ANIM_2.speed_scale = lerp(0.0, top_anim_speed, alpha)
