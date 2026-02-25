extends Node3D

@export var bul: Sprite3D
@export var MARK : Node3D
@export var DIR_MARK : Node3D

@onready var anim_pl: AnimationPlayer = $AnimationPlayer
@onready var hz: Timer = $hz


const bullet_path = preload("res://Creatures/Simple_Player/weapons/smaller_high_hz_bullet.tscn")
var is_shooting := false



func _ready() -> void:
	#anim_pl.speed_scale = 1.5
	pass



func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("+mouse_left") and is_shooting == false and !Input.is_action_just_pressed("+mouse_right"):
		shoot()
	elif Input.is_action_just_pressed("+mouse_right") and is_shooting == false and !Input.is_action_just_pressed("+mouse_left"):
		reload()



func shoot():
	is_shooting = true
	hz.start()
	anim_pl.play("def")
	anim_pl.play("atk")

	if bul.rotation.y <= deg_to_rad(-145.0) and bul.rotation.y >= deg_to_rad(-155.0):
		$fuck.play()
		Globus.player.PL_HP.take_damage(1, true)

	else:
		$AudioStreamPlayer.pitch_scale = randf_range(0.7, 1.7)
		$AudioStreamPlayer.play()
		var bullet = bullet_path.instantiate()
		bullet.position = MARK.global_position
		bullet.rotation = DIR_MARK.rotation
		bullet.speed += 3
		bullet.dmg = 5
		get_parent().add_child(bullet)

	bul.rotate_y(deg_to_rad(60))
	print(rad_to_deg(bul.rotation.y))
	await hz.timeout
	is_shooting = false



func reload():
	is_shooting = true
	if anim_pl.is_playing():
		await anim_pl.animation_finished
	$reload.start()
	var n = randi_range(1, 6)
	bul.rotate_y(deg_to_rad(60 * n))
	#anim_pl.play("def")
	anim_pl.play("reaload")
	await anim_pl.animation_finished
	is_shooting = false
