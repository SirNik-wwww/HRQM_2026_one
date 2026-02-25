extends Area3D

@onready var locked_door: StaticBody3D = $"../Node3D/locked_door"
@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var actived := false

func _on_body_entered(_body: Node3D) -> void:
	if actived == false:
		actived = !actived
		var terminal = Vector3(locked_door.position.x, locked_door.position.y -4, locked_door.position.z)
		get_tree().create_tween().tween_property(locked_door, "position", terminal, 0)
		sprite_3d.visible = false
		audio_stream_player.play()


func reset_room():
	actived = false
	var terminal_back = Vector3(locked_door.position.x, locked_door.position.y * 0, locked_door.position.z)
	get_tree().create_tween().tween_property(locked_door, "position", terminal_back, 0)
	sprite_3d.visible = true
