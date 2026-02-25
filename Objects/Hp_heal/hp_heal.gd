extends Node3D



var PLAYER : Player

func _ready() -> void:
	PLAYER = Globus.player

func _on_area_3d_body_entered(body: Node3D) -> void:

	PLAYER.PL_HP.pl_hp_change(-1, false)
	queue_free()
