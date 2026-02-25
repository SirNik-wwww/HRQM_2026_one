class_name FallPlayerState extends PlayerMovementState


func enter() -> void:
	ANIM_2.pause()


func update(_delta):
	if PLAYER.is_on_floor():
		Trans.emit("WalkPlayerState")

	#if PLAYER.velocity.length() > 0.0 and !PLAYER.is_on_floor():
		#Trans.emit("FallPlayerState")

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("+ctrl"):
		#Trans.emit("WalkPlayerState")

	#if event.is_action_pressed("+space"):
		#Trans.emit("JumpPlayerState")
#
	#if event.is_action_pressed("+shift"):
		#Trans.emit("RunPlayerState")
