extends CanvasLayer
#class_name Dialogue_Balloon

@export var LINES : Array[String]
@export var CTSCN_GROUP : String
@export var TEXT_LABEL: RichTextLabel

@onready var timer: Timer = $Timer
@onready var anim_pl: AnimationPlayer = $AnimationPlayer

var active : bool = true
var input_actions = ["+mouse_right", "+mouse_left", "+mouse_mid", "_jump"]
var line_index := 0
var line_for_ctscn := -1
var activated := false
var is_typng : bool = false
var number_of_letters : int
var text_speed : float = 35
var text_skipped : bool = false


func _ready() -> void:
	set_process_input(false)
	set_process(false)

	#TranslationServer.set_locale("en")

func show_line(need_line := line_index):
	if need_line >= LINES.size():
		if activated == false:
			activated = !activated
			get_tree().call_group(CTSCN_GROUP, "end_ctscn")
		return
	else:
		#print("START")
		is_typng = true
		TEXT_LABEL.text = tr(LINES[need_line])
		TEXT_LABEL.visible_ratio = 0
		line_for_ctscn += 1
		get_tree().call_group(CTSCN_GROUP, "action_action")

		number_of_letters = TEXT_LABEL.get_total_character_count()
		var time = text_speed / number_of_letters
		anim_pl.play("typing", -1, time)
		await anim_pl.animation_finished

		#print("done")
		#print(line_for_ctscn)
		#if text_skipped == false:
		line_index += 1
		#await get_tree().create_timer(0.3).timeout
		is_typng = false
		#print("END")



func _input(event: InputEvent) -> void:
	for action in input_actions:
		if event.is_action_pressed(action) and active == true:
			if is_typng == true:
				anim_pl.play("fast")
				#await anim_pl.animation_finished
				#text_skipped = true
				#line_index += 1
			else:
				show_line()
	if event.is_action_pressed("-quick_debug(2)"):
		get_tree().call_group(CTSCN_GROUP, "end_ctscn")
