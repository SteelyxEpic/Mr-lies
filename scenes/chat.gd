extends Node2D

@onready var chatting: PackedScene = load("res://chatting.tscn")
@onready var peoplebox: PackedScene = load("res://peoplebox.tscn")
@onready var chattingarea: VBoxContainer = $chatbox/VBoxContainer
@onready var chattingareascroll: ScrollContainer = $chatbox
@onready var peopleare: VBoxContainer = $people/VBoxContainer
@onready var next: Button = $Button
var current: Array[Dictionary] = []
var currenttext: String = ""

func _ready() -> void:
	for i in Global.data["people_known"]:
		var instance = peoplebox.instantiate()
		peopleare.add_child(instance)
		instance.text = i.keys()[0]
		instance.pressed.connect(func():
			check(i.keys()[0])
			)

func chat(recap: bool = false):
	var instance = chatting.instantiate()
	instance.text = current[0]["message"]
	if current[0]["messager"] == "me":
		instance.set_horizontal_alignment(2)
	chattingarea.add_child(instance)
	if !recap:
		for i in range(len(Global.data["people_known"])):
			if currenttext == Global.data["people_known"][i].keys()[0]:
				Global.data["people_known"][i][currenttext] += current[0]["messager"] + "," + current[0]["message"] + ","
				break
	current.remove_at(0)
	await get_tree().process_frame
	var scrollbar = chattingareascroll.get_v_scroll_bar()
	chattingareascroll.scroll_vertical = int(scrollbar.max_value)
	if len(current) == 0 and !recap:
		next.hide()

func check(cur: String):
	
	for i in range(len(Global.data["people_known"])):
		if currenttext == Global.data["people_known"][i].keys()[0]:
			var temp = ""
			for x in current:
				temp += x["messager"] + "," + x["message"] + ","
			Global.data["people_known"][i]["queue"] = temp
			break
	currenttext = cur
	for i in range(len(Global.data["people_known"])):
		if currenttext == Global.data["people_known"][i].keys()[0]:
			current = Global.convertor(Global.data["people_known"][i][currenttext])
			
			for x in chattingarea.get_children():
				x.queue_free()
			for x in range(len(current)):
				await chat(true)
				
			current = Global.convertor(Global.data["people_known"][i]["queue"])
			if len(current) > 0:
				next.show()
			else:
				next.hide()
			break
			
	
