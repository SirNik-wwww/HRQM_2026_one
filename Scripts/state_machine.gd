class_name StM extends Node

@export var CUR_ST : St
var sts: Dictionary = {}

func _ready():
	for child in get_children():
		if child is St:
			sts[child.name] = child #добовление в словарь
			child.Trans.connect(on_child_transition)
		else:
			push_warning("SM содержит незавершонную дочернию ноду")

	await owner.ready
	CUR_ST.enter()

func _process(delta : float):
	CUR_ST.update(delta)
	#Globus.debug.add_prop("Cur_St", CUR_ST.name, 3)

func  _physics_process(delta : float):
	CUR_ST.phys_upd(delta)

func on_child_transition(new_st_name: StringName) -> void:
	var new_st = sts.get(new_st_name)
	if new_st != null:
		if new_st != CUR_ST:
			CUR_ST.exit()
			new_st.enter()
			CUR_ST = new_st
	else:
		push_warning("Состояние не существует")
