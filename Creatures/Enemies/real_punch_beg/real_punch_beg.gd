extends Area3D

var is_dead = false

func take_damage(how_much = 1, _is_it_damage := true):
	if how_much >= 1 and is_dead == false:
		$Sprite3D_main.modulate = Color(1, 0, 0)
		await  get_tree().create_timer(0.1).timeout
		$Sprite3D_main.modulate = Color(1, 1, 1)
	if how_much > 1 and is_dead == false:
		is_dead = !is_dead
		$AnimationPlayer.play("damage")
		$Sprite3D_low.modulate = Color(1, 0, 0)
		$Sprite3D_up.modulate = Color(1, 0, 0)
		await $AnimationPlayer.animation_finished
		$Sprite3D_low.modulate = Color(1, 1, 1)
		$Sprite3D_up.modulate = Color(1, 1, 1)

func move(direction : StringName):
	if direction == "right":
		pass
	if direction == "left":
		pass
	if direction == "up":
		pass
	if direction == "forward":
		pass
