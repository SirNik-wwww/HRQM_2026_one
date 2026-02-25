extends Area3D

class_name CutTscn

@export var AUDIO_PL: AudioStreamPlayer
@export var CTSCN_CAM: Camera3D
@export var D_BALLOON : CanvasLayer
var PLAYER: Player

var input_actions = ["+mouse_right", "+mouse_left", "+mouse_mid", "_jump"]
var actived : bool = false


func _ready() -> void:
	set_process_input(false)
	self.add_to_group("CTSCN_GROUP")

	self.connect(&"body_entered", Callable(self, "start_ctscn"))
	PLAYER = Globus.player


func switch(active: bool):
	if active == true:
		PLAYER.process_mode = Node.PROCESS_MODE_DISABLED
		set_process_input(true)
	#else :
		#show_d_balloon(false)
	PLAYER.CAMERA_CONTROLLER.current = !active
	CTSCN_CAM.current = active
	#PLAYER.input_able = !active
	PLAYER.velocity = Vector3(0,0,0)
	PLAYER.visible = !active
	PLAYER.cross.visible = !active


func set_cam_pos(new_pos):
	CTSCN_CAM.global_position = new_pos.global_position
	CTSCN_CAM.global_basis = new_pos.global_basis

func move_cam(new_pos, time):
	get_tree().create_tween().tween_property(CTSCN_CAM, "position", new_pos.position, time)
	get_tree().create_tween().tween_property(CTSCN_CAM, "global_basis", new_pos.global_basis, time)


func show_d_balloon(_show : bool):
	#print(show)
	if _show == true:
		D_BALLOON.show_line()
	D_BALLOON.set_process_input(_show)
	D_BALLOON.visible = _show


func sprite_bouce(_sprite :Node3D, _scale :float =0.95, time :float =0.13):
	var old_sc = _sprite.scale
	var new_scale_tall = Vector3(old_sc.x / _scale, old_sc.y * _scale, old_sc.z / _scale)
	var new_scale_short = Vector3(old_sc.x * _scale, old_sc.y / _scale, old_sc.z * _scale)

	get_tree().create_tween().tween_property(_sprite, "scale", new_scale_tall, time)
	await get_tree().create_timer(time).timeout
	get_tree().create_tween().tween_property(_sprite, "scale", new_scale_short, time)
	await get_tree().create_timer(time).timeout
	get_tree().create_tween().tween_property(_sprite, "scale", old_sc, time)


func return_sprite_scale(_sprite :Node3D, _scale :float =0.2):
	_sprite.scale = Vector3(_scale, _scale, _scale)

#
#func sprite_rot(dir : Vector3, _sprite :Node3D, _rot :float =159, time :float =0.53):
	#var deg_rot = rad_to_deg(_rot)
	##get_tree().create_tween().tween_property(_sprite, "rotate", deg_rot, time)
	#


func play_sound(sound, vol : float = 1, pich : float = 1.0):
	AUDIO_PL.pitch_scale = pich
	AUDIO_PL.stream = sound
	AUDIO_PL.volume_db = vol
	AUDIO_PL.play()
