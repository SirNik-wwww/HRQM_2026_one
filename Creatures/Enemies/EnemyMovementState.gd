extends St
class_name EnemyMovementState

var SELF
var PLAYER : Player
var ANIM
#var dir

func _ready() -> void:
	await owner.ready

	SELF = owner
	PLAYER = Globus.player
	ANIM = SELF.ANIM_PL
