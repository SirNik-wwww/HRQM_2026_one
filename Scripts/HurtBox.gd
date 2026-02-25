class_name HurtBox
extends Area3D

#var damage_able : bool = true
var dmg : int
var need_more_strength = 1.34

func take_damage(how_much := 1, is_it_damage := true):
	if how_much <= 0:
		how_much = 0
	else:
		dmg = how_much
		owner.take_damage(how_much, is_it_damage)
	

func move(direction : StringName):
	owner.set_collision_layer_value(3, false)
	owner.set_collision_mask_value(2, false)
	owner.set_collision_mask_value(3, false)
	owner.can_move = false
	if direction == "right":
		#var pl_pos = Globus.player.global_transform.origin # Получаем позицию игрока
		var pl_forward = -Globus.player.global_transform.basis.z.normalized()  # Получаем направление взгляда игрока (вперед)
		var right_dir = pl_forward.cross(Vector3.UP).normalized() # Вычисляем вектор вправо от игрока (перпендикулярно направлению взгляда)
		owner.velocity = right_dir * owner.speed * dmg * need_more_strength
	if direction == "left":
		#var pl_pos = Globus.player.global_transform.origin # Получаем позицию игрока
		var pl_forward = -Globus.player.global_transform.basis.z.normalized()  # Получаем направление взгляда игрока (вперед)
		var left_dir = -pl_forward.cross(Vector3.UP).normalized() # Вычисляем вектор вправо от игрока (перпендикулярно направлению взгляда)
		owner.velocity = left_dir * owner.speed * dmg * need_more_strength
	if direction == "up":
		owner.velocity.y += dmg * 2
	if direction == "forward":
		#var pl_pos = Globus.player.global_transform.origin # Получаем позицию игрока
		var pl_forward = -Globus.player.global_transform.basis.z.normalized()  # Получаем направление взгляда игрока (вперед)
		owner.velocity = pl_forward * owner.speed * dmg * need_more_strength * 1.5
	await get_tree().create_timer(1.0).timeout
	owner.can_move = true
	owner.set_collision_layer_value(3, true)
	owner.set_collision_mask_value(2, true)
	owner.set_collision_mask_value(3, true)
