extends CharacterBody3D

@onready var mesh: MeshInstance3D = $MeshInstance3D

@export var HEALTH_COLOR : String = "blu"

var lives : int
var beatable = true

var PLAYER

func _ready() -> void:
	PLAYER = Globus.player


func take_damage(how_much = 1, is_it_damage := true):
	if is_it_damage == true:
		if beatable == true:
			beatable = !beatable
			lives -= how_much

			PLAYER.PIG_COL.add_pigment(HEALTH_COLOR, 1) # добавляет пигмент


			beatable = !beatable
	else:
		lives += how_much
