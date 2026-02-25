class_name AtkKirt_2State extends EnemyMovementState

var bullet_path = preload("res://Creatures/Enemies/common/test_bullet.tscn")
@onready var raycast: RayCast3D = $"../../Raycast"


func enter() -> void:
	SELF.velocity.x = 0
	SELF.velocity.z = 0

	if PLAYER.is_dead == true:
		Trans.emit("StanKirt_2State")
		return


	ANIM.play("atk")
	await ANIM.animation_finished
	$"../../AudioStreamPlayer3D".play()
	if SELF.lives <= 0:
		Trans.emit("DeadKirt_2State")

	ANIM.play("akt_commit")
	

	var bullet = bullet_path.instantiate()
	raycast.look_at(PLAYER.position)
	bullet.position = SELF.global_position
	bullet.rotation = raycast.rotation
	get_parent().add_child(bullet)

	await ANIM.animation_finished

	if SELF.lives <= 0:
		Trans.emit("DeadKirt_2State")

	SELF.atk_timer.start()

	Trans.emit("ChaseKirt_2State")
