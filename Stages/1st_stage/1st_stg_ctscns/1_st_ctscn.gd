extends CutTscn

@onready var camera_3d: Camera3D = $"../Camera3D"
@onready var the_mf: AnimatedSprite3D = $"../../the_log/the_mf"
@onready var gg: AnimatedSprite3D = $"../gg"

@onready var audio_pl: AudioStreamPlayer = $"../AudioStreamPlayer"
const C_1_AH = preload("res://Sound/SE/voices/C_1_Ah.mp3")
const C_2_EH = preload("res://Sound/SE/voices/C_2_eh.mp3")
const C_3_HEH = preload("res://Sound/SE/voices/C_3_heh.mp3")
const GG_2_PROBLY = preload("res://Sound/SE/voices/GG_2_probly.mp3")
const INECRAFT_VILLAGER = preload("uid://dp11xrmg7vg3")

@onready var sprite_marisa: Sprite3D = $"../SpriteMarisa"

func start_ctscn(_body : Node3D):
	if actived == false:
		actived = true
		set_cam_pos(PLAYER.CAMERA_CONTROLLER)

		switch(true)
		move_cam($"../markers/Camera3D", 0.4)
		show_d_balloon(true)

		#the_mf.play("hello")
		audio_pl.play()
		sprite_bouce(sprite_marisa, 0.9, 0.23)
		#sprite_marisa.rotate_x(rad_to_deg(310))
		#sprite_rot(sprite_marisa)



func end_ctscn():
	D_BALLOON.active = false
	$"../gg".visible = false
	#the_mf.play("idle")
	switch(false)
	PLAYER.NUNCH.visible = true
	show_d_balloon(false)

	PLAYER.process_mode = Node.PROCESS_MODE_INHERIT
	await get_tree().create_timer(0.3).timeout

	PLAYER.NUNCH.process_mode = Node.PROCESS_MODE_INHERIT

	D_BALLOON.queue_free()
	queue_free()



func action_action():
	if D_BALLOON.line_for_ctscn == 1:
		#the_mf.play("idle")
		gg.visible = true
		CTSCN_CAM.current = false
		$"../markers/Camera3D2".current = true

		sprite_bouce(gg)
		play_sound(GG_2_PROBLY, 1.4, 0.97)

	if D_BALLOON.line_for_ctscn == 2:
		
		play_sound(INECRAFT_VILLAGER, 1.1, 1.5)
		CTSCN_CAM.current = true
		$"../markers/Camera3D2".current = false
		set_cam_pos($"../markers/Camera3D")
		sprite_bouce(the_mf, 0.99, 0.23)


	if D_BALLOON.line_for_ctscn == 6:
		show_d_balloon(false)
		sprite_bouce(sprite_marisa, 0.6, 0.4)
		await get_tree().create_timer(2).timeout
		
		#the_mf.play("nunch")
		#await get_tree().create_timer(1).timeout
		set_cam_pos($"../markers/Camera3D2")
		gg.play("WHAT")
		play_sound(GG_2_PROBLY, 1.4, 1.2)
		the_mf.play("idle")
		await get_tree().create_timer(0.3).timeout
		show_d_balloon(true)
