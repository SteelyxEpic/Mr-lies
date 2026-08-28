extends Node

var shut = false
var save_location = "user://save.json"
var default: Dictionary = {
	"reputation": 0,
	"money": 0,
	"people_known": [],
  "searches": {
	"Dickson": {
	  "news": {
		"Dickson hosts first community bicycle race": "Dickson 'Dylan' Dinnerbone has successfully hosted the first annual Dermont Bicycle Rally. Over 300 residents participated in the event, with Dickson personally leading the opening lap.",
		
		"Golopicks announces ultra-budget model": "Golopicks has revealed its newest bicycle, the 'Dinnerbone Lite', which is expected to retail for only $75. The company says it hopes to make cycling affordable for everyone."
	  },

	  "Media": {
		"Dinnerbone Lite": "Working on a cheaper version of the Dinnerbone Pro~ Hope everyone likes it!",
		
		"Bicycle Rally": "The race was amazing!!! Thanks to everybody who joined!",
		
		"Fourteenicle": "Just gave the fourteenicle a fresh paint job. It somehow looks even sillier now."
	  }
	},
	"Betty Herman": {
  "news": {
	"Golden Horse employee receives customer praise": "Betty Herman, a waitress at the Golden Horse, has recently received numerous positive reviews from customers. Several patrons cited her friendly attitude and excellent service.",
	
	"Local restaurant staff member celebrates 5 years of service": "Golden Horse has congratulated Betty Herman on completing five years of service with the restaurant. Management thanked her for her dedication and commitment to customer satisfaction.",

	"Golden Horse prepares for busy April": "With several events scheduled throughout April, Betty Herman and the Golden Horse team are preparing for one of the busiest months of the year."
  },

  "Media": {
	"My birthday soon!~": "My birthday is coming up in almost 2 weeks! I can't believe it!~~",

	"Important annoucement!": "Tomorrow, at 11th April, I'll be making an important annoucement! Don't miss it~",

	"Morning shift done!": "Finally finished today's shift~ Thanks to everyone who dropped by the Golden Horse today!",

	"Best coworkers ever": "Couldn't ask for a better team to work with 💖",

	"Recipe disaster": "Tried making a cake at home today... let's just say the smoke alarm wasn't impressed 😭"
  }
},

"Golden Horse": {
  "news": {
	"Golden Horse introduces seasonal menu": "The Golden Horse has announced a limited-time seasonal menu featuring several new desserts and beverages.",

	"Restaurant sees rise in visitors": "Management at the Golden Horse reports that customer numbers have steadily increased over the past few months."
  },

  "Media": {
	"Many thanks to Jessica Joling for allowing us to be the location for her 21st Birthday!": "We hope everybody enjoys the celebration!",

	"April event preparations": "We're getting ready for several exciting celebrations this month!",

	"Staff Spotlight": "Today's staff spotlight goes to Betty Herman for her hard work and dedication!"
  }
},

"Jessica Joling": {
  "news": {
	"Jessica Joling announces birthday celebration plans": "Local resident Jessica Joling has confirmed that she will be hosting her upcoming birthday celebration at the Golden Horse restaurant.",

	"Jessica thanks restaurant staff": "Jessica Joling expressed her appreciation for the staff at Golden Horse after a recent visit, particularly highlighting Betty Herman's service."
  },

  "Media": {
	"Shoutout to betty at golden horse!": "She was a wonderful waitress and has the same birthday as me. We were def meant to be!",

	"Remember that restuarant I went to?": "Well I'm going to celebrate my bday there! Mark your calendar for 22 April!~ we're going to have a feast!",

	"Birthday countdown": "Only a few more days until my birthday!! 🎉",

	"Party planning": "Still deciding on the cake flavor... any suggestions??",

	"Golden Horse again": "Went back to Golden Horse today. The food somehow gets better every visit!"
  }
}
  },

  "Email": {
	"Mother's bday help": "Help!!! My name is Garwin Gooder and I forgot my mother's birthday ;-; I need you to help me please, I have her contact and her name if you accept.|Garwin1",
  },

"text": {
	"Garwin1": "Garwin=me,hello! Is this Garwin?,Garwin,Yes! If you're texting does that mean you accepted my request?,me,yeap,me,you said you can provide me with information about your mother first?,Garwin,Yes! Her name is Betty Herman,Garwin,born in 1996,Garwin,and she is working at the Golden Horse,Garwin,Please help me,me,I'll see what I can do,Garwin,thank youu!|22/4/1996|Garwinyes|Garwinno",
	"Garwinyes":"Garwin=Garwin,That's the one!,Garwin,Thanks a lot!,me,no problem,me,I am expecting my payment soon tho,Garwin,yes! Of course!,Garwin,You'll get it in your account soon!+100_30",
	"Garwinno":"Garwin=Garwin,...,Garwin,no that's not it_-5|22/4/1996|Garwinyes|Garwinno",
}
,
"read":[]}
var data: Dictionary

func _ready() -> void:
	data = load_data()
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
