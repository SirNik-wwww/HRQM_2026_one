extends Area3D

@onready var static_body_3d: StaticBody3D = $"../StaticBody3D"

var actived = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect(&"body_entered", Callable(self, "start_encounter"))

	Globus.enemy_died.connect(en_check)
	var _3rd_room = [$"../enemies3/kirt", $"../enemies3/kirt2", $"../enemies3/kirt3", $"../enemies3/kirt4", $"../enemies3/kirt5", $"../enemies3/kirt6"]
	for enemy in _3rd_room:
		enemy.add_to_group("3rd_room")

func start_encounter(body : Node3D):
	if actived == false:
		actived = !actived
		get_tree().call_group("3rd_room", "turn_on")

func en_check():
	#print(get_tree().get_nodes_in_group("3rd_room").size())
	if get_tree().get_nodes_in_group("3rd_room").size() <= 0:
		get_parent().remove_child(static_body_3d)
		static_body_3d.queue_free()
		get_parent().remove_child(self)
		queue_free()
