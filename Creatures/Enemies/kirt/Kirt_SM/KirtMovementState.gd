class_name KirtMovementState extends St

var SELF : Kirt
var PLAYER : Player
var ANIM: AnimatedSprite3D
var dir

func _ready() -> void:
	
	await owner.ready

	SELF = owner
	PLAYER = Globus.player
	ANIM = SELF.anim_sp_pl

func _process(delta: float) -> void:
	if PLAYER != null:
		dir = SELF.dir
	else:
		return
