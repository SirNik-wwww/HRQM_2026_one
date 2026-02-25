class_name AtkBandit_RState extends EnemyMovementState


var bullet_path = preload("res://Creatures/Enemies/common/test_bullet.tscn")
@onready var raycast: RayCast3D = $"../../raycast_holder/Raycast"


func enter() -> void:
	SELF.velocity.x = 0
	SELF.velocity.z = 0

	ANIM.play("atk")
	$"../../Atk_commit/Pre_Atk".play()
	await ANIM.animation_finished

	if SELF.lives <= 0:
		return

	if PLAYER.is_dead == true:
		Trans.emit("StanBandit_RState")
		return

	if SELF.lives <= 0:
		return

	else:
		pass

	$"../../Atk_commit".play()
	ANIM.play("atk_commit")

	var bullet = bullet_path.instantiate()
	raycast.look_at(PLAYER.position)
	bullet.position = raycast.global_position
	bullet.rotation = raycast.rotation
	get_parent().add_child(bullet)

	await ANIM.animation_finished

	if SELF.lives <= 0:
		return

	SELF.ATK_TIMER.start()

	Trans.emit("ChaseBandit_RState")
