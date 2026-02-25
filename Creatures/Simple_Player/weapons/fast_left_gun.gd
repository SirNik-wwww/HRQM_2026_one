extends Node3D
@onready var hz: Timer = $hz
@onready var anim_pl: AnimationPlayer = $AnimationPlayer

@export var MARK : Node3D
@export var DIR_MARK : Node3D
const bullet_path = preload("res://Creatures/Simple_Player/weapons/smaller_high_hz_bullet.tscn")

var can_shoot := true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("+mouse_left") and can_shoot == true:
		if  Input.is_action_pressed("+d") and !Input.is_action_pressed("+a"):
			$Sprite3D2.visible = false
			shoot()
			anim_pl.speed_scale = 1
			anim_pl.play("fire")
		if  !Input.is_action_pressed("+d") or Input.is_action_pressed("+a"):
			$Sprite3D2.visible = true
			$fuck.play()
	if Input.is_action_just_released("+mouse_left"):
		get_tree().create_tween().tween_property(anim_pl, "speed_scale", 0, 0.4)
		$Sprite3D2.visible = false


func shoot():
	can_shoot = false
	$AudioStreamPlayer.pitch_scale = randf_range(0.7, 1.7)
	$AudioStreamPlayer.play()
	var bullet = bullet_path.instantiate()
	bullet.position = MARK.global_position
	bullet.rotation = DIR_MARK.rotation
	bullet.speed += 3
	bullet.dmg = randi_range(1, 3)
	get_parent().add_child(bullet)
	hz.start()
	await hz.timeout
	can_shoot = true
