extends Area3D

@onready var static_body_3d: StaticBody3D = $"../StaticBody3D"

var group_number : String = "test_1_room"
var actived = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	self.connect(&"body_entered", Callable(self, "start_encounter"))

	Globus.enemy_died.connect(en_check)
	var room = [$"../Node3D/kirt", $"../Node3D/kirt2", $"../Node3D/kirt3", $"../Node3D/kirt4", $"../Node3D/kirt5", $"../Node3D/kirt6", $"../Node3D/kirt7", $"../Node3D/kirt8", $"../Node3D/kirt9", $"../Node3D/kirt10", $"../Node3D/kirt11"
	]
	for enemy in room:
		enemy.add_to_group(group_number)

func start_encounter(body : Node3D):
	if actived == false:
		actived = !actived
		get_tree().call_group(group_number, "turn_on")

func en_check():
	print(get_tree().get_nodes_in_group(group_number).size())
	if get_tree().get_nodes_in_group(group_number).size() <= 1:
		get_parent().remove_child(static_body_3d)
		static_body_3d.queue_free()
		get_parent().remove_child(self)
		queue_free()
