extends Area3D

#@onready var static_body_3d: StaticBody3D = $"../StaticBody3D"
@onready var static_body_3d: StaticBody3D = $"../StaticBody3D"

var actived = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.add_to_group("Needs_be_save")
	self.connect(&"body_entered", Callable(self, "start_encounter"))

	Globus.enemy_died.connect(en_check)
	var _2st_room = [$"../enemies2/kirt", $"../enemies2/kirt2", $"../enemies2/kirt3", $"../enemies2/kirt4", $"../enemies2/kirt7", $"../enemies2/kirt5", $"../enemies2/kirt6", $"../enemies2/Kirt_2", $"../enemies2/Kirt_3", $"../enemies2/Kirt_4", $"../enemies2/Kirt_5"]
	for enemy in _2st_room:
		enemy.add_to_group("2st_room")

func start_encounter(body : Node3D):
	if actived == false:
		actived = !actived
		get_tree().call_group("2st_room", "turn_on")

func en_check():
	#print(get_tree().get_nodes_in_group("2st_room").size())
	if get_tree().get_nodes_in_group("2st_room").size() <= 0:
		get_parent().remove_child(static_body_3d)
		static_body_3d.queue_free()
		get_parent().remove_child(self)
		queue_free()



#############################################################
##__________________ Сохранение ___________________________##
func on_save_game(saved_data : Array[SavedData]):
	pass

func on_load_game(saved_data : SavedData):
	actived = false
#############################################################
#############################################################
