extends Camera3D


var shakeFade : float # время за которое тряска уменьшается до нуля (чем больше - тем быстрее, почему-то)
var shake_power : float = 0.0

var rnd = RandomNumberGenerator.new()

func apply_shake(custom_shake_power, custom_shake_fade):
	shake_power = custom_shake_power
	shakeFade = custom_shake_fade

func randomOffset() -> Vector3:
	return Vector3(
		rnd.randf_range(-shake_power, shake_power),
		rnd.randf_range(-shake_power, shake_power),
		rnd.randf_range(-shake_power, shake_power)
		)

func _process(delta: float) -> void:
	if shake_power > 0.0:
		shake_power = lerpf(shake_power, 0, shakeFade * delta)
		position = randomOffset()
