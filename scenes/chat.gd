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
var ansindex: int = 0
var decipher: String
var chance: float

func _ready() -> void:
	recheck()

func recheck():
	$choice.hide()
	for i in chattingarea.get_children():
		i.queue_free()
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
	var special = {
		"ques": ["|", 0, 0],
		"gain": ["+", 0, 0],
		"rep": ["_", 0, 0],
		"choice": [">", 0, 0],
		"option": ["`", 0, 0],
		"chat": ["*", 0, 0]
	}
	var temp = []
	if current[0]["message"].contains("&"):
		var answers  = Global.data["Gibberish"].pick_random()
		if chance > randf_range(0, 250):
			answers = Global.data["Codes"][decipher]
		current[0]["message"] = current[0]["message"].replace("&", answers)
	instance.text = current[0]["message"]
	for i in special.keys():
		special[i][1] = instance.text.find(special[i][0])
		special[i][2] = instance.text.count(special[i][0])
		if special[i][1] > 0:
			temp.append(i)
		instance.text = instance.text.replace(special[i][0], "|")
	temp.sort_custom(func(a, b):
		return special[a][1] < special[b][1])
	Ans = instance.text.split("|")
	instance.text = Ans[0]
	instance.text = Global.checkkeyword(instance.text)
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
	for i in range(len(temp)):
		if temp[i] == "gain" and !recap:
			var money = Ans[i + 1].to_float()
			var moneyinstance = Global.notifs.instantiate()
			$"../../notifbox".add_child(moneyinstance)
			if money > 0:
				moneyinstance.get_node("margin").get_node("text").text = "$" + Ans[i + 1] + " added into your account!"
			else:
				moneyinstance.get_node("margin").get_node("text").text = "$" + str(abs(money)) + " deducted from your account"
			Global.data["money"] += money
		elif temp[i] == "rep" and !recap:
			Global.data["reputation"] += Ans[i + 1].to_float()
		elif temp[i] == "ques" and len(current) == 0:
			ansindex = i
			$choice.show()
			for x in $choice/ScrollContainer/content.get_children():
				x.queue_free()
			for x in Global.data["keywords_gotten"]:
				var choiceinstance = Button.new()
				choiceinstance.text = x
				$choice/ScrollContainer/content.add_child(choiceinstance)
				choiceinstance.pressed.connect(func():
					$choice.hide()
					truecheck(x)
				)
		elif temp[i] == "chat" and !recap:
			var content = Global.data["text"][Ans[i + 1]].split("=")
			var hasnopeople = true
			for y in range(len(Global.data["people_known"])):
				if content[0] == Global.data["people_known"][y].keys()[0]:
					Global.data["people_known"][y]["queue"] += content[1]
					hasnopeople = false
					break
			if hasnopeople:
				Global.data["people_known"].append({content[0]:"", "queue":content[1]})
			recheck()
		elif temp[i] == "choice":
			if len(current) == 0:
				$choice.show()
				for x in $choice/ScrollContainer/content.get_children():
					x.queue_free()
				for x in range(special["choice"][2]):
					var choiceinstance = Button.new()
					var choice = Ans[i + x + 1].split("<")
					choiceinstance.text = choice[0]
					$choice.show()
					$choice/ScrollContainer/content.add_child(choiceinstance)
					choiceinstance.pressed.connect(func():
						$choice.hide()
						var choicetemp = "me," + choice[0] + ","
						if len(choice) > 1:
							var content = Global.data["text"][choice[1]].split("=")
							choicetemp += content[1] + ","
						for y in range(len(Global.data["people_known"])):
							if currenttext == Global.data["people_known"][y].keys()[0]:
								Global.data["people_known"][y]["queue"] = choicetemp
								break
						check(currenttext)
					)
		elif temp[i] == "option" and len(current) == 0:
			unknownchoice()
	if len(current) == 0 and !recap:
		next.hide()
		currentalert.hide()
		for i in range(len(Global.data["people_known"])):
			if currenttext == Global.data["people_known"][i].keys()[0]:
				Global.data["people_known"][i]["queue"] = ""
				break

func reload():
	if len(current) > 0:
		for i in range(len(Global.data["people_known"])):
			if currenttext == Global.data["people_known"][i].keys()[0]:
				var temp = ""
				for x in current:
					temp += x["messager"] + "," + x["message"] + ","
				temp = temp.left(-1)
				Global.data["people_known"][i]["queue"] = temp
				break
func check(cur: String):
	$answer.hide()
	$choice.hide()
	for x in $choice/ScrollContainer/content.get_children():
		x.queue_free()
	if currenttext != cur:
		reload()
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
				$answer.hide()
				$choice.hide()
				next.show()
				chat()
			else:
				if currenttext == "Unknown" and not($choice/ScrollContainer/content.get_child_count() > 0):
					unknownchoice()
				next.hide()
			break
			
	
func unknownchoice():
	$choice.show()
	for x in $choice/ScrollContainer/content.get_children():
		x.queue_free()
	for x in Global.data["keywords_gotten"]:
		var choiceinstance = Button.new()
		choiceinstance.text = x
		
		$choice/ScrollContainer/content.add_child(choiceinstance)
		choiceinstance.pressed.connect(func():
			$choice.hide()
			var choicetemp = "me," + x + ","
			var response = "Unknown,Hmmm,Unknown,....,Unknown,I don't know what this is,Unknown,Maybe it's information that a person wants`,"
			if currenttext == "Unknown":
				for i in Global.data["searches"].keys():
					if x == i:
						response = "Unknown,Hmmm,Unknown,....,Unknown,try searching this,Unknown,Maybe something important will show`,"
						break
				for i in Global.data["Codes"].keys():
					if x == i:
						response = "Unknown,Hmmm,Unknown,....,Unknown,It's a code that needs to be deciphered,Unknown,I can decipher it for you,Unknown,....,Unknown,for a price>What's the price?<tutorialdecipher>No thanks<tutorialnodecipher"
						decipher = x
						chance = 250
						break
				for i in Global.data["Codes"].values():
					if x == i:
						response = "Unknown,Hmmm,Unknown,....,Unknown,It's a deciphered code,Unknown,somebody probably wants it,Unknown,Who knows`	"
						
						break
				for i in Global.data["decipherers"].keys():
					if x == i:
						response = "Unknown,Hmmm,Unknown,....,Unknown,It's a decipherer,Unknown,Luckily for you,Unknown,I actually know this person,Unknown,Do you want me to contact them?>Yes<" + x + ">No thanks<tutorialnodecipher"
						
						break
			elif Global.data["decipherers"].keys().has(currenttext):
				response = currenttext + ",Uhm,,I don't think this is a key,,At least not a key I can decipher,,you got anything else?`"
				for i in Global.data["Codes"].keys():
					if x == i:
						response = "Unknown,Hmmm,Unknown,....,Unknown,Yea I can decipher this,Unknown,It'll cost you around " + str(Global.data["decipherers"][currenttext] * 4) + ",Unknown,you in?>Yes<tutorialdecipheryes"+currenttext+">No thanks<tutorialnodecipher"
						decipher = x
						chance = Global.data["decipherers"][currenttext]
						break
			choicetemp += response
			for y in range(len(Global.data["people_known"])):
				if currenttext == Global.data["people_known"][y].keys()[0]:
					Global.data["people_known"][y]["queue"] = choicetemp
					break
			check(currenttext)
		)
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
	var checkans = dateformatter(answer.get_node("LineEdit").text)
	$answer/dateconfirm.show()
	$answer/dateconfirm/date.text = checkans
	var yesbutton: Button = $answer/dateconfirm/Yes
	for i in yesbutton.pressed.get_connections():
		yesbutton.pressed.disconnect(i.callable)
	yesbutton.pressed.connect(func():
		truecheck(checkans))
	$answer/dateconfirm/No.pressed.connect(func():
		$answer/dateconfirm.hide())
	
	
func truecheck(answers):
	var temp = "me," + answers + ","
	if answers.contains(Ans[ansindex + 1]):
		var content = Global.data["text"][Ans[ansindex + 2]].split("=")
		temp += content[1] + ","
	else:
		var content = Global.data["text"][Ans[ansindex + 3]].split("=")
		temp += content[1] + ","
	for i in range(len(Global.data["people_known"])):
		if currenttext == Global.data["people_known"][i].keys()[0]:
			Global.data["people_known"][i]["queue"] = temp
			break
	
	check(currenttext)
