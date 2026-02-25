extends Node3D


@onready var hz: Timer = $hz
@onready var anim_pl: AnimationPlayer = $AnimationPlayer
@export var MARK : Node3D
@export var DIR_MARK : Node3D

const bullet_path = preload("uid://bo5oi84bryeus")
var can_shoot := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
	create_bullet()
	create_bullet()
	create_bullet()
	create_bullet()
	create_bullet()
	
	hz.start()
	await hz.timeout
	can_shoot = true


func create_bullet():
	var bullet = bullet_path.instantiate()
	bullet.global_position = MARK.global_position
	bullet.rotation = DIR_MARK.rotation
	bullet.top_level = true
	get_parent().add_child(bullet)
