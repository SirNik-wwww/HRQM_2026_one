extends Node3D

var PLAYER : Player
var bgm_pl : AudioStreamPlayer
var cur_volume : float

@onready var blackness: ColorRect = $CanvasLayer/Control/ColorRect

const BOY_OH_BOY = preload("res://Sound/BGM/stolen/Widdly 2 Diddly - LISA Soundtrack - 18 Boy Oh Boy.mp3")
const WELCOME_HOME = preload("res://Sound/BGM/stolen/Widdly 2 Diddly - LISA Soundtrack - 68 Welcome Home.mp3")
const ODE_TO_THE_OBSCURE = preload("res://Sound/BGM/Ode to the Overjoyed.mp3")

@onready var g_m_e: Node = $Global_Music_etc

var first_music_actived := false
var calmdown_actived = false

func _ready() -> void:
	Globus.is_on_stage = true
	#TranslationServer.set_locale("en")
	bgm_pl = g_m_e.bgm
	bgm_pl.volume_db = -990.0
	#cur_volume = bgm_pl.volume_db
	#bgm_pl.stop()

	PLAYER = Globus.player
	await get_tree().create_timer(0.5).timeout
	#if PLAYER.NUNCH != null:
		#PLAYER.NUNCH.visible = false
		#PLAYER.NUNCH.process_mode = Node.PROCESS_MODE_DISABLED
		#pass
	#else:
		#print("No")
	


	
	#g_m_e.bgm.play()




func _on_play_calm_body_entered(_body: Node3D) -> void:
	bgm_pl.stream = BOY_OH_BOY
	bgm_pl.volume_db = -70.0
	bgm_pl.play()
	get_tree().create_tween().tween_property(bgm_pl, "volume_db", -15, 4.4)



func _on_calm_end_body_entered(_body: Node3D) -> void:
	if calmdown_actived == false:
		calmdown_actived = !calmdown_actived
		get_tree().create_tween().tween_property(bgm_pl, "volume_db", -70, 1.4)
	#bgm_pl.play()


func _on_room_encounter_body_entered(_body: Node3D) -> void:

	if first_music_actived == false:
		print("SSASdAD")
		first_music_actived = !first_music_actived
		bgm_pl.stream = ODE_TO_THE_OBSCURE
		bgm_pl.volume_db = -6
		bgm_pl.play()
		print("SSASdAD111111")
