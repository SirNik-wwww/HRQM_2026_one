extends AudioStreamPlayer

@export var hit_box : Node3D

func check():
	if hit_box.is_colliding():
		pitch_scale = randf_range(0, 10)
		play()
