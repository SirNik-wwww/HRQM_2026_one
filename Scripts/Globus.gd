extends Node

signal enemy_died # для подсчёта оставшихся противников в комнате

var debug

var player

var check_point : bool # проверяет был ли пересечён хотя бы 1 чекпоинт

var is_on_stage : bool = false

func _ready() -> void:
	set_process_mode(Node.PROCESS_MODE_ALWAYS)
	check_point = false

func _useless():
	enemy_died.emit()
	# только чтобы проводник не ругался
