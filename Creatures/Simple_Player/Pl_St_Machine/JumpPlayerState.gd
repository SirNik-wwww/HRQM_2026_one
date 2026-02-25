class_name JumpPlayerState extends PlayerMovementState

@export var JUMP_VEL = 4.2

func enter() -> void:
	if PLAYER.input_able == true and PLAYER.is_on_floor() == true:
		ANIM_2.play("jump")
		PLAYER.velocity.y += JUMP_VEL
	#print("jump")


func update(_delta):
	if PLAYER.is_on_floor():
		Trans.emit("WalkPlayerState")



#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("+ctrl"):
		#Trans.emit("WalkPlayerState")
