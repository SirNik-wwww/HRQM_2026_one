extends CharacterBody3D

const JUMP_VELOCITY = 4.5

var can_move = true
var speed = 30.0
var gravity := 100.0
var dmg := 10

func _ready() -> void:
	velocity.y += 10
	#var pl_vel = Globus.player.velocity.x * 4
	velocity += transform.basis * Vector3(0, 0, - speed)
	velocity += Vector3(randf_range(-3, 3), randf_range(-3, 3),randf_range(-3, 3))
	velocity += Globus.player.velocity * 4 

func _physics_process(_delta: float) -> void:
	if not is_on_floor() and can_move:
		velocity.y -= gravity * _delta
	move_and_slide()


func _on_area_hit_body_entered(_body: Node3D) -> void:
	$Sprite3D.visible = false
	can_move = false
	velocity = Vector3(0,0,0)
	await get_tree().create_timer(0.01).timeout # нужен, чтобы фиксировались попадания в близи
	var hitted = $Area_boom.get_overlapping_areas()

	for en in hitted:
		if en.has_method("take_damage"):
			en.take_damage(dmg, true)

	$Area_boom/CollisionShape3D.disabled = true
	$Timer_Flee.stop()
	$CPUParticles3D.emitting = true
	await get_tree().create_timer(0.4).timeout

	queue_free()


func _on_timer_flee_timeout() -> void:
	queue_free()
