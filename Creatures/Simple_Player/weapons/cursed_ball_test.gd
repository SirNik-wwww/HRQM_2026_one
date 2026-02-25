extends CharacterBody3D

var speed : float = 2.0
var dmg : int = 2
var can_move := true

#func _ready() -> void:
	#var hitted = $Area3D_for_boom.get_overlapping_areas()
		#pass
		#print(hitted)
	
func _physics_process(_delta: float) -> void:
	if can_move == true:
		velocity += transform.basis * Vector3(0, 0, -speed)
	move_and_slide()


func _on_timer_timeout() -> void:
	get_parent().remove_child(self)
	queue_free()



# урон или исчезновение
func _on_area_3d_for_env_body_entered(_body: Node3D) -> void: # для окружения
	can_move = false
	$Sprite3D.visible = false
	boom()
	#var hitted = $Area3D_for_boom.get_overlapping_areas()
#
	#for en in hitted:
		#if en.has_method("take_damage"):
			#en.take_damage(dmg, true)
			#print("AAAA")


#func _on_area_3d_for_enemies_area_entered(_area: Area3D) -> void: # для противников
	

func boom():
	await get_tree().create_timer(0.01).timeout # нужен, чтобы фиксировались попадания в близи
	var hitted = $Area3D_for_boom.get_overlapping_areas()


	for en in hitted:
		if en.has_method("take_damage"):
			en.take_damage(dmg, true)

	$Area3D_for_boom/CollisionShape3D.disabled = true
	$Timer_Flee.stop()

	$CPUParticles3D.emitting = true
	await get_tree().create_timer(0.4).timeout
	#print("end")

	queue_free()
