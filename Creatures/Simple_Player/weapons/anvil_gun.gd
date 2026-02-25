extends Node3D


@onready var hz: Timer = $hz
@onready var anim_pl: AnimationPlayer = $AnimationPlayer
@export var MARK : Node3D
@export var DIR_MARK : Node3D

const bullet_path = preload("uid://dbwx6w6mt46c7")

var can_shoot := true


func _process(_delta: float) -> void:
	if Input.is_action_pressed("+mouse_left") and can_shoot == true:
		shoot()
	#if Input.is_action_just_released("+mouse_left"):
		#get_tree().create_tween().tween_property(anim_pl, "speed_scale", 0, 0.4)
		#$Sprite3D2.visible = false


func shoot():
	can_shoot = false
	$AudioStreamPlayer.pitch_scale = randf_range(0.7, 1.7)
	$AudioStreamPlayer.play()
	var bullet = bullet_path.instantiate()
	bullet.global_position = MARK.global_position
	bullet.top_level = true
	#bullet.rotation = DIR_MARK.rotation
	#bullet.speed += 3
	#bullet.dmg = randi_range(1, 3)
	get_parent().add_child(bullet)
	hz.start()
	await hz.timeout
	can_shoot = true
