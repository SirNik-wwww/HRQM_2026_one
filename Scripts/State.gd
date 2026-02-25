class_name St extends Node

signal Trans(new_st_name: StringName) #Transition

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func phys_upd(_delta: float) -> void: # Physics update
	pass



func _useless():
	Trans.emit()
	# только чтобы проводник не ругался
