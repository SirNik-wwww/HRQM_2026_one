extends PanelContainer

@onready var prop_cont = $MarginContainer/VBoxContainer

var fps : String

func _ready():
	visible = true

	Globus.debug = self

func _process(delta):
	if visible:
		fps = "%.2f" % (1.0/delta)
	Globus.debug.add_prop("FPS", fps, 0)


func _input(event):
	if event.is_action_pressed("-debug_f"):
		visible = !visible


func add_prop(title : String, value, order): # add debug property
	var target
	target = prop_cont.find_child(title, true, false) # Пытаемся найти текстовую ноду с темже иминем
	if !target: # if there is no current Lebel node for property (ie. inital load) (Я хз)
		target = Label.new() # создаём новую текстовую ноду
		prop_cont.add_child(target) # добавляем новую ноду как дочернию для VBox cont
		target.name = title # Set name to title
		target.text = target.name + ": " + str(value) # set text value
	elif visible:
		target.text = title + ": " + str(value) # update text value
		prop_cont.move_child(target, order) # Reorder prop based on given order value
