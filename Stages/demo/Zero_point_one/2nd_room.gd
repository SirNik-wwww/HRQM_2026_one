extends Area3D


@onready var static_body_3d: StaticBody3D = $"../StaticBody3D"
@onready var backdoor: StaticBody3D = $"../backdoor"

#@onready var door_collision_shape_3d: CollisionShape3D = $"../backdoor/CollisionShape3D"
#@onready var door_sprite_3d: AnimatedSprite3D = $"../backdoor/Sprite3D"

@onready var audio_stream_player: AudioStreamPlayer = $"../AudioStreamPlayer"

const victory_sound = preload("res://Sound/SE/Something/796078_(CUT and PROCESSED )_claytonkb__electric-vehicle-ev-emergency-orchestra-hit.wav")

var group_number : String = "2_room"
var actived = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.add_to_group("Start_enc_area")
	self.connect(&"body_entered", Callable(self, "start_encounter"))
	#door_collision_shape_3d.disabled = true

	Globus.enemy_died.connect(en_check)
	var room = [
	$"../emenies2/Bandit_Range", $"../emenies2/Bandit_Range2", $"../emenies2/Bandit_Range3", $"../emenies2/Bandit_Range4", $"../emenies2/Bandit_Range5", $"../emenies2/Bandit_Melee5", $"../emenies2/Bandit_Melee6", $"../emenies2/Bandit_Melee7", $"../emenies2/Bandit_Melee8", $"../emenies2/Bandit_Melee9"
	]
	for enemy in room:
		enemy.add_to_group(group_number)

func start_encounter(_body : Node3D):
	if actived == false:
		actived = !actived
		audio_stream_player.play()
		get_tree().call_group(group_number, "turn_on")
		var terminal_back = Vector3(backdoor.position.x, backdoor.position.y +4, backdoor.position.z)
		get_tree().create_tween().tween_property(backdoor, "position", terminal_back, 0.4)
		var terminal_1 = Vector3(static_body_3d.position.x, static_body_3d.position.y +5.1, static_body_3d.position.z)
		get_tree().create_tween().tween_property(static_body_3d, "position", terminal_1, 0.4)


func reset_room():
	actived = false
	var terminal_back = Vector3(backdoor.position.x, backdoor.position.y -4, backdoor.position.z)
	get_tree().create_tween().tween_property(backdoor, "position", terminal_back, 0)
	var terminal_1 = Vector3(static_body_3d.position.x, static_body_3d.position.y -5.1, static_body_3d.position.z)
	get_tree().create_tween().tween_property(static_body_3d, "position", terminal_1, 0)
	

func en_check():
	#print(get_tree().get_nodes_in_group(group_number).size())
	if get_tree().get_nodes_in_group(group_number).size() <= 0:
		audio_stream_player.stream = victory_sound
		audio_stream_player.volume_db = -3
		audio_stream_player.play()

		var terminal_back = Vector3(backdoor.position.x, backdoor.position.y -4, backdoor.position.z)
		get_tree().create_tween().tween_property(backdoor, "position", terminal_back, 0.4)
		var terminal_1 = Vector3(static_body_3d.position.x, static_body_3d.position.y -5.1, static_body_3d.position.z)
		get_tree().create_tween().tween_property(static_body_3d, "position", terminal_1, 0.4)

		get_parent().remove_child(self)
		queue_free()
		
