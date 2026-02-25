class_name AtkBandit_AkState extends EnemyMovementState


var bullet_path = preload("res://Creatures/Enemies/common/test_bullet.tscn")
@onready var raycast: RayCast3D = $"../../raycast_holder/Raycast"

var cicle := 0
var is_shooting := false

func enter() -> void:
	ANIM.play("walk")
	$"../../Atk_Timer".start()
	

func exit() -> void:
	$"../../Atk_Timer".stop()
	cicle = 0



func shoot():
	var bullet = bullet_path.instantiate()
	raycast.look_at(PLAYER.position)
	bullet.position = raycast.global_position
	var rnd_rot =  raycast.rotation + Vector3(randf_range(-0.1, 0.1), randf_range(-0.1, 0.1), randf_range(-0.1, 0.1))
	bullet.rotation = rnd_rot
	get_parent().add_child(bullet)
	$"../../Atk_Timer".start()

	$"../../Atk_commit".play()


func update(_delta: float) -> void:
	if cicle >= 30:
		Trans.emit("ChaseBandit_AkState")
		return

	if is_shooting == false and cicle < 30:
		is_shooting = true
		shoot()
		cicle += 1

	if SELF.lives <= 0:
		return

	if PLAYER.is_dead == true:
		Trans.emit("StanBandit_AkState")
		return

	if SELF.lives <= 0:
		return

	else:
		pass


	#if SELF.lives <= 0:
		#return
#
	#SELF.ATK_TIMER.start()
#
	#Trans.emit("ChaseBandit_RState")


func _on_atk_timer_timeout() -> void:
	shoot()
	is_shooting = false
