extends Node2D

@onready var chatting: PackedScene = load("res://chatting.tscn")
@onready var peoplebox: PackedScene = load("res://peoplebox.tscn")
@onready var chattingarea: VBoxContainer = $chatbox/VBoxContainer
@onready var chattingareascroll: ScrollContainer = $chatbox
@onready var peopleare: VBoxContainer = $people/VBoxContainer
@onready var answer: Node2D = $answer
@onready var next: Button = $next
var current: Array[Dictionary] = []
var currentalert: Sprite2D
var currenttext: String = ""
var Ans:PackedStringArray

func _ready() -> void:
	recheck()

func recheck():
	for i in peopleare.get_children():
		i.queue_free()
	for i in Global.data["people_known"]:
		var instance = peoplebox.instantiate()
		peopleare.add_child(instance)
		if i["queue"] != "":
			instance.get_node("Alert").show()
		else:
			instance.get_node("Alert").hide()
		instance.text = i.keys()[0]
		instance.pressed.connect(func():
			if currentalert == instance.get_node("Alert"):
				if len(current) != 0:
					chat()
			else:
				check(i.keys()[0])
				currentalert = instance.get_node("Alert")
			)

func chat(recap: bool = false):
	var instance = chatting.instantiate()
	var ques = current[0]["message"].contains("|")
	if ques:
		Ans = current[0]["message"].split("|")
		instance.text = Ans[0]
		
	else:
		instance.text = current[0]["message"]
	if current[0]["messager"] == "me":
		instance.set_horizontal_alignment(2)
	chattingarea.add_child(instance)
	if !recap:
		for i in range(len(Global.data["people_known"])):
			if currenttext == Global.data["people_known"][i].keys()[0]:
				Global.data["people_known"][i][currenttext] += current[0]["messager"] + "," + current[0]["message"] + ","
				break
		await get_tree().process_frame
		await get_tree().process_frame
		var scrollbar = chattingareascroll.get_v_scroll_bar()
		chattingareascroll.scroll_vertical = int(scrollbar.max_value)
	current.remove_at(0)
	if len(current) == 0 and !recap:
		if ques:
			$answer.show()
		next.hide()
		currentalert.hide()

func check(cur: String):
	if currenttext != cur:
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
				chat(true)
			await get_tree().process_frame
			await get_tree().process_frame
			var scrollbar = chattingareascroll.get_v_scroll_bar()
			chattingareascroll.scroll_vertical = int(scrollbar.max_value)
				
			current = Global.convertor(Global.data["people_known"][i]["queue"])
			if len(current) > 0:
				next.show()
				chat()
			else:
				next.hide()
				
			break
			
	

func dateformatter(date_str: String) -> String:
	var text = date_str.to_lower().strip_edges()

	# Remove ordinal suffixes
	text = text.replace("st", "")
	text = text.replace("nd", "")
	text = text.replace("rd", "")
	text = text.replace("th", "")

	# Convert separators to spaces
	text = text.replace("/", " ")
	text = text.replace("-", " ")
	text = text.replace(",", " ")
	text = text.replace(".", " ")

	var parts = text.split(" ")

	var months = {
		"january": 1, "jan": 1,
		"february": 2, "feb": 2,
		"march": 3, "mar": 3,
		"april": 4, "apr": 4,
		"may": 5,
		"june": 6, "jun": 6,
		"july": 7, "jul": 7,
		"augu": 8, "aug": 8,
		"september": 9, "sep": 9,
		"october": 10, "oct": 10,
		"november": 11, "nov": 11,
		"december": 12, "dec": 12
	}

	var day := -1
	var month := -1
	var year := -1

	# Look for month name
	for part in parts:
		if months.has(part):
			month = months[part]

	# Format: August 11 2004
	if month != -1:
		var numbers = []
		for part in parts:
			if part.is_valid_int():
				numbers.append(int(part))

		if numbers.size() >= 2:
			day = numbers[0]
			year = numbers[1]

	# Format: 11 08 2004
	elif parts.size() == 3:
		if parts[0].is_valid_int():
			day = int(parts[0])

		if parts[1].is_valid_int():
			month = int(parts[1])

		if parts[2].is_valid_int():
			year = int(parts[2])

	# Convert two-digit year
	if year < 100:
		year += 2000

	return (
		str(day) + "/" + str(month) + "/" + str(year)
	)
	

func checkanswer():
	$answer.hide()
	var checkans = dateformatter(answer.get_node("LineEdit").text)
	var temp = "me," + checkans + ","
	if checkans.contains(Ans[1]):
		var content = Global.data["text"][Ans[2]].split("=")
		temp += content[1] + ","
	else:
		var content = Global.data["text"][Ans[3]].split("=")
		temp += content[1] + ","
	for i in range(len(Global.data["people_known"])):
		if currenttext == Global.data["people_known"][i].keys()[0]:
			Global.data["people_known"][i]["queue"] = temp
			print(Global.data["people_known"][i]["queue"])
			break
	
	check(currenttext)
