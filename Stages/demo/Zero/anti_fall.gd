extends Area3D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer




func _on_body_entered(body: Node3D) -> void:
	body.position = Vector3(1.0, 7.0, 1.0)
	audio_stream_player.play()
