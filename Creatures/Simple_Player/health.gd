extends Node2D


@onready var down = $down
@onready var up = $up
@onready var left = $left

var Co = 1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("+q"):
		if Co == 3:
			down.visible = true
			up.visible = false
			left.visible = false
			Co = 2
			print(Co)
		elif Co == 1:
			down.visible = false
			up.visible = true
			left.visible = false
			Co = 3
			print(Co)
		elif Co == 2:
			down.visible = false
			up.visible = false
			left.visible = true
			Co = 1
			print(Co)
		
