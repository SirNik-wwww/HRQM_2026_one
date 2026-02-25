extends CutTscn

@onready var blackness: ColorRect = $"../../../../CanvasLayer/Control/ColorRect"
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	PLAYER = Globus.player
	var D_balloon_group = D_BALLOON.CTSCN_GROUP
	self.add_to_group(str(D_balloon_group))
	#start_ctscn()
	#blackness.color = (Color(0.0, 0.0, 0.0, 1.0))



func start_ctscn():
	if actived == false:
		actived = true
		PLAYER.CAMERA_CONTROLLER.current = false
		#CTSCN_CAM.current = true
		switch(true)
		show_d_balloon(true)
		#D_BALLOON.visible = false

func end_ctscn():
	D_BALLOON.active = false
	switch(false)
	show_d_balloon(false)

	PLAYER.process_mode = Node.PROCESS_MODE_INHERIT
	await get_tree().create_timer(0.3).timeout

	D_BALLOON.queue_free()
	queue_free()

func action_action():
	if D_BALLOON.line_for_ctscn == 1:
		blackness.color = (Color(0.0, 0.0, 0.0, 0.0))
		#D_BALLOON.visible = true
		$"../AnimationPlayer".play("cam_down")
	
	if D_BALLOON.line_for_ctscn == 2:
		$"../AnimationPlayer".play("cam_away")
