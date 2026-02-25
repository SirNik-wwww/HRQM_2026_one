class_name PlayerMovementState extends St


var PLAYER : Player
var ANIM: AnimationPlayer
var ANIM_2: AnimationPlayer

func _ready() -> void:
	
	await owner.ready
	PLAYER = owner as Player
	PLAYER = Globus.player
	ANIM = PLAYER.ANIM_PL
	ANIM_2 = PLAYER.ANIM_PL_2
