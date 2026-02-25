extends Node3D

@export var CAM : Camera3D
@export var PLAYER : Player

@onready var se_heal: AudioStreamPlayer = $se_heal
@onready var sfx_damage: AudioStreamPlayer = $sfx_damage


@onready var shield_label: Label3D = $shield/Label3D

const GAMEOVER_SCREEN = preload("res://Creatures/Simple_Player/interface/GameOver_test.tscn")


var pl_lives : int = 6
var shields : int = 0
var can_get_damage : bool = true

@onready var _1: Sprite3D = $"circle/1"
@onready var _2: Sprite3D = $"circle/2"
@onready var _3: Sprite3D = $"circle/3"
@onready var _4: Sprite3D = $"circle/4"
@onready var _5: Sprite3D = $"circle/5"
@onready var _6: Sprite3D = $"circle/6"

@onready var shield_spr: Sprite3D = $shield
@onready var anti_instakill_timer: Timer = $"Anti-instakill_Timer"



#var hp_bar : Array = [
	#$"circle/1",
	#$"circle/2",
	#$"circle/3",
	#$"circle/4",
	#$"circle/5",
	#$"circle/6"
#]

func take_damage(how_much : int, is_it_damage : bool):
	if PLAYER.coun_atk_ready == true:
		PLAYER.dgm_received = how_much
		get_tree().call_group("Coun_atk", "counterattak", how_much)
		
	
	if PLAYER.is_dead != true and PLAYER.inf_hp != true and PLAYER.coun_atk_ready != true and can_get_damage == true:
		if how_much <= 0:
			how_much = 0
			#anti_instakill_timer.start()

		if is_it_damage == true:
			var change = how_much
			how_much -= shields
			shields -= change
			if shields < 0:
				shields = 0
			shield_label.text = str(shields)
			if how_much <= 0:
				how_much = 0

			pl_lives -= how_much
			CAM.apply_shake(0.05, 4.0)
			sfx_damage.play()
			can_get_damage = false
			anti_instakill_timer.start()
		else:
			pl_lives += how_much
			se_heal.play()
		
		if shields != 0:
			shield_spr.visible = true
		if shields == 0:
			shield_spr.visible = false
		
	else:
		return
	check_hp()

func check_hp():
	
	#########################################
	##____________ АД _____________________##
	if pl_lives >= 6:
		pl_lives = 6
		_1.show()
		_2.show()
		_3.show()
		_4.show()
		_5.show()
		_6.show()
	elif pl_lives == 5:
		_1.show()
		_2.show()
		_3.show()
		_4.show()
		_5.show()
		_6.hide()
	elif pl_lives == 4:
		_1.show()
		_2.show()
		_3.show()
		_4.show()
		_5.hide()
		_6.hide()
	elif pl_lives == 3:
		_1.show()
		_2.show()
		_3.show()
		_4.hide()
		_5.hide()
		_6.hide()
	elif pl_lives == 2:
		_1.show()
		_2.show()
		_3.hide()
		_4.hide()
		_5.hide()
		_6.hide()
	elif pl_lives == 1:
		_1.show()
		_2.hide()
		_3.hide()
		_4.hide()
		_5.hide()
		_6.hide()
	elif pl_lives <= 0:
		_1.hide()
		_2.hide()
		_3.hide()
		_4.hide()
		_5.hide()
		_6.hide()
		pl_die()

	#print(pl_lives)
	#await get_tree().create_timer(0.5).timeout

func pl_die():
	if PLAYER.is_dead != true:
		PLAYER.add_child(GAMEOVER_SCREEN.instantiate())
		PLAYER.input_able = false
		PLAYER.velocity = Vector3(0, 0, 0)

	#PLAYER.set_physics_process(false)

	#PLAYER.paused = true

func add_shield(how_much : int):
	$se_shield.play()
	shields += how_much
	shield_spr.visible = true
	shield_label.text = str(shields)


func _on_antiinstakill_timer_timeout() -> void:
	can_get_damage = true
