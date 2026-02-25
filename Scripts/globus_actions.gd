extends Node

@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"


var window = false # отладка
var fullscreen = false


func _ready() -> void:
	set_process_mode(Node.PROCESS_MODE_ALWAYS)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("_full_screen"):
		#print("FFFFF")
		if fullscreen == false:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			fullscreen = !fullscreen
			print("FFFFF")
		elif fullscreen == true:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			fullscreen = !fullscreen
			print("TTTTTTTT")


	if Input.is_action_just_pressed("-restart_debug"):
		#if PAUSE_MENU.is_paused == true:
			#PAUSE_MENU.pausing_func()
		get_tree().reload_current_scene()

		#$"../Save".load_pl_progress()


#=========================================================================
#========================================= ОТЛАДКА =======================
	if Input.is_action_just_pressed("-show_mouse"):
		if window == false:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		elif window == true:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		window = !window

	if Input.is_action_just_pressed("-quit"):
		get_tree().quit()
#=========================================================================
#=========================================================================


	if Input.is_action_just_pressed("-save_game"):
		#Globus.save_game()
		#$"../Save".save_pl_progress()
		
		pass
	
	if Input.is_action_just_pressed("-load_game"):
		

		#$"../Save".load_pl_progress()
		#Globus.load_game()
		#Globus.player.position = Globus.save().save_dict
		pass
