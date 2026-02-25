extends CharacterBody3D

var speed : float = 2.0

func _physics_process(_delta: float) -> void:
	velocity += transform.basis * Vector3(0, 0, -speed)
	move_and_slide()


# урон или исчезновение
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		Globus.player.PL_HP.take_damage(1, true)
	
	$Timer.stop()
	#get_parent().remove_child(self)
	queue_free()


func _on_timer_timeout() -> void:
	get_parent().remove_child(self)
	queue_free()
