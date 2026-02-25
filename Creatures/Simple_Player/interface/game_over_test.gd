extends CanvasLayer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Globus.player.is_dead = true

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("+restart"):
		if Globus.check_point == false:
			get_tree().reload_current_scene()
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			Globus.player.is_dead = false
			Globus.player.input_able = true
			get_parent().remove_child(self)
			queue_free()
