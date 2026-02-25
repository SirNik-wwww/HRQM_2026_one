class_name IdlePlayerState extends PlayerMovementState


func enter() -> void:
	ANIM_2.play("idle")
	#print("idle")


func update(_delta):
	if PLAYER.velocity.length() > 0.0 and PLAYER.is_on_floor():
		Trans.emit("WalkPlayerState")

	if PLAYER.velocity.length() > 0.0 and !PLAYER.is_on_floor():
		Trans.emit("FallPlayerState")

	if PLAYER.input_able == false:
		Trans.emit("DeadPlayerState")

func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("+ctrl"):
		#Trans.emit("WalkPlayerState")

	if event.is_action_pressed("_jump") and PLAYER.is_on_floor():
		Trans.emit("JumpPlayerState")

	#if event.is_action_pressed("+shift"):
		#Trans.emit("RunPlayerState")
