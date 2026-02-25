extends Area3D

@onready var static_body_3d: StaticBody3D = $"../StaticBody3D"
@onready var audio_stream_player: AudioStreamPlayer = $"../AudioStreamPlayer"

const victory_sound = preload("res://Sound/SE/Something/796078_(CUT and PROCESSED )_claytonkb__electric-vehicle-ev-emergency-orchestra-hit.wav")

var group_number : String = "1_room"
var actived = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.add_to_group("Start_enc_area")
	self.connect(&"body_entered", Callable(self, "start_encounter"))

	Globus.enemy_died.connect(en_check)
	var room = [
	$"../emenies1/Hog", $"../emenies1/Bandit_Range", $"../emenies1/Bandit_Range2", $"../emenies1/Bandit_Range3", $"../emenies1/Bandit_Range4", $"../emenies1/Bandit_Melee", $"../emenies1/Bandit_Melee2", $"../emenies1/Bandit_Melee3", $"../emenies1/Bandit_Melee4", $"../emenies1/Bandit_Melee5"
	]
	for enemy in room:
		enemy.add_to_group(group_number)

func start_encounter(_body : Node3D):
	if actived == false:
		actived = !actived
		audio_stream_player.play()
		get_tree().call_group(group_number, "turn_on")

func en_check():
	#print(get_tree().get_nodes_in_group(group_number).size())
	if get_tree().get_nodes_in_group(group_number).size() <= 0:
		audio_stream_player.stream = victory_sound
		audio_stream_player.volume_db = -3
		audio_stream_player.play()
		get_parent().remove_child(static_body_3d)
		static_body_3d.queue_free()
		get_parent().remove_child(self)
		queue_free()
