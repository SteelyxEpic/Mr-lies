extends Node

var shut = false
var save_location = "user://save.json"
var default: Dictionary = {"people_known": [{"Mother": "", "queue": "Mother,Son! How have you been?,me,fine!,me,Is there anything you want from me?, Mother,Well you should know what I want from you,Mother,or have you forgotten about it already,me,uhm,me,uhm,me,of course not! I was just waiting for a good time to say it!,Mother,well then I’m waiting….,me,uhm….."}, {"John": "", "queue": ""}, {"Rod": "", "queue": ""}]}
var data: Dictionary

func _ready() -> void:
	data = load_data()
	convertor("mother,hello!,me,bye!mother,hello!,me,bye!mother,hello!,me,bye!mother,hello!,me,bye!")
	override()
	
func override():
	data = default
	save()
	
func convertor(value: String) -> Array[Dictionary]:
	var temp = value.split(",")
	var tempdict:Array[Dictionary] = []
	for i in range(0, len(temp)/2):
		tempdict.append({"messager": temp[i*2], "message": temp[i*2 + 1]})
	return tempdict
		
		
func save():
	var file: FileAccess = FileAccess.open(save_location, FileAccess.WRITE)
	var str_data = JSON.stringify(data)
	file.store_line(str_data)
	file.close()

func load_data() -> Dictionary:
	if FileAccess.file_exists(save_location):
		var file: FileAccess = FileAccess.open(save_location, FileAccess.READ)
		var json = JSON.new()
		var datatemp = file.get_line()
		json.parse(datatemp) 
		var dataf: Dictionary = json.get_data()
		file.close()
		return dataf
	return default
