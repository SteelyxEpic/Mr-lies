extends Node

var shut = false
var end:bool = false
var save_location = "user://save.json"
@onready var notifs: PackedScene = load("res://notifs.tscn")
const default: Dictionary = {
	"reputation": 0,
	"money": 100,
	"people_known": [{"Unknown":"", "queue":"Unknown,Hey>Uhm hi?<tutorial2>Who are you?<tutorial1"}],
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
},
"decipher": {
  "news": {
	"New decipherers found": "A new decipherer known as mighty cipher has been surfaced as the best 'money for value' decipherer in the web"
  },

  "Media": {
	"Today's decipherer spotlight: deluxe bitcoin": "Cheap as a lunch, effective as a buck! Use in moderation~",

	"Today's decipherer spotlight: The best in the world": "The name says it all, it's the best but uses the money of the greatest amount",

	"Today's decipherer spotlight: noisy carer": "Worst of the worst but money be damned, use if in need of something quick"
  }
},"Arthur Pendelton": {
  "news": {
	"Local museum robbed": "The Dermont City Museum was robbed late last night. The famous painting 'The Crying Gull' is missing. Authorities say former security guard Arthur Pendelton is a person of interest.",
	"Suspect evades capture": "Police raided Arthur Pendelton's apartment this morning but found it empty. Neighbors reported seeing him leave with a large suitcase late Sunday evening."
  },
  "Media": {
	"Time for a break": "Packing my bags! Leaving for a long 'vacation' to Sunnyville tonight. Don't try to call me, dropping off the grid for a bit! 🏖️",
	"Easy money": "People really don't appreciate art until it's gone, huh?",
	"Throwback": "Missing the old days working at the museum. Not missing the paycheck though."
  }
},

"Sunnyville": {
  "news": {
	"Sunnyville Port tightens security": "Following recent smuggling reports, the Sunnyville Port Authority has announced they will be increasing security checks for all outbound passenger ferries.",
	"Sunnyville weather update": "Expect heavy rain for the next three days in the Sunnyville coastal region."
  },
  "Media": {
	"Ferry delays": "Ugh, the ferry out of Sunnyville is delayed AGAIN. I've been waiting at the docks for two hours.",
	"Beautiful town": "Just arrived in Sunnyville. The beaches are absolutely gorgeous this time of year!"
  }
}
  },

  "Email": {

},
"Quest":{
	"Mother's bday help": "Help!!! My name is Garwin Gooder and I forgot my mother's birthday ;-; I need you to help me please, I have her contact and her name if you accept.|Garwin1",
	"Strange Message": "My friend sent me the phrase IS3eY00 and refused to explain what it means. Can you figure out the decoded word for me?|CodeQuest1",  
	"Bicycle Scoop": "I work for a rival bike manufacturer. We need to know the exact name of Golopicks' new ultra-budget model before they officially launch it. Find it for us.|BikeSpy1",
	"Stolen Art": "A famous painting was stolen last night. The prime suspect is Arthur Pendelton. We need to know the name of the location he is fleeing to so we can intercept him.|ArtThief1",
	"Locked File": "I found an encrypted drive. The password hint is the decoded version of X7yZ99. Help me out bro.|CipherDoc1"
},

"text": {
	"Garwin1": "Garwin=me,hello! Is this Garwin?,Garwin,Yes! If you're texting does that mean you accepted my request?,me,yeap,me,you said you can provide me with information about your mother first?,Garwin,Yes! Her name is Betty Herman,Garwin,born in 1996,Garwin,and she is working at the Golden Horse,Garwin,Please help me,me,I'll see what I can do,Garwin,thank youu!|22 April|Garwinyes|Garwinno",
	"Garwinyes":"Garwin=Garwin,That's the one!,Garwin,Thanks a lot!,me,no problem,me,I am expecting my payment soon tho,Garwin,yes! Of course!,Garwin,You'll get it in your account soon!+100_30>Pleasure doing business<Garwinthank>Thank you kindly<Garwinthank",
	"Garwinno":"Garwin=Garwin,...,Garwin,no that's not it_-5|22 April|Garwinyes|Garwinno",
	"Garwinthank":"Garwin=Garwin,Thanks again!",
	"CodeQuest1":"MysteryClient=me,Can you decode IS3eY00 for me?|Hopscotch|CodeQuestYes|CodeQuestNo",
	"CodeQuestYes":"MysteryClient=MysteryClient,Hopscotch! That's it!,MysteryClient,Thank you!+200_50>Glad I could help<CodeQuestThanks",
	"CodeQuestNo":"MysteryClient=MysteryClient,That doesn't seem right._-15|Hopscotch|CodeQuestYes|CodeQuestNo",
	"CodeQuestThanks":"MysteryClient=MysteryClient,You're amazing!",
	"BikeSpy1": "RivalCorp=me,I have accepted your request.,RivalCorp,Excellent.,RivalCorp,What is the exact name of the new budget bicycle model made by Dickson?|Dinnerbone Lite|BikeSpyYes|BikeSpyNo",
	"BikeSpyYes": "RivalCorp=RivalCorp,Dinnerbone Lite? Interesting. We can undercut that price.,RivalCorp,Thank you for the intel.+150_40>Pleasure doing business<BikeSpyThanks",
	"BikeSpyNo": "RivalCorp=RivalCorp,That doesn't match our partial intel. Look at Golopicks' announcements._-10|Dinnerbone Lite|BikeSpyYes|BikeSpyNo",
	"BikeSpyThanks": "RivalCorp=RivalCorp,We will contact you if we need more corporate info in the future.",
	"ArtThief1": "Detective=me,I'm on the case.,Detective,Good. We don't have much time.,Detective,Where is Arthur Pendelton heading?|Sunnyville|ArtThiefYes|ArtThiefNo",
	"ArtThiefYes": "Detective=Detective,Sunnyville? We'll alert the port authorities to lock down the ferries immediately.,Detective,Great detective work.+300_100>Happy to help<ArtThiefThanks",
	"ArtThiefNo": "Detective=Detective,That's a dead end. Look closer at his recent social media posts._-20|Sunnyville|ArtThiefYes|ArtThiefNo",
	"ArtThiefThanks": "Detective=Detective,Case closed. The suspect is in custody.",
	"CipherDoc1": "HackerPal=me,I can decode that for you.,HackerPal,Sweet! What is X7yZ99 decoded?|Blueberry|CipherDocYes|CipherDocNo",
	"CipherDocYes": "HackerPal=HackerPal,Blueberry! The drive is unlocking!,HackerPal,You're a lifesaver.+250_60>Have fun<CipherDocThanks",
	"CipherDocNo": "HackerPal=HackerPal,Access denied. That wasn't it._-15|Blueberry|CipherDocYes|CipherDocNo",
	"CipherDocThanks": "HackerPal=HackerPal,Time to see what's inside this drive...",
	"tutorial1":"Unknown=Unknown,Not important,me,...,me,ok?,unknown,the important thing is that you chose to become a spy right?>Yes<tutorialyes>No<tutorialno",
	"tutorial2":"Unknown=Unknown,let me ask you a question,Unknown,do you want to become a spy?>Yes<tutorialyes>No<tutorialno",
	"tutorialyes":"Unknown=Unknown,ok good,Unknown,I'll teach you the basics of gathering information...,Unknown,but the rest is up to you,Unknown,your computer already has a web engine prepared,Unknown,we will funnel requests into your mailbox,Unknown,there should be a few in it right now,Unknown,Quest accepted must be finished during that day,Unknown,There's a period from 00:00 to 08:00 where all accepted quests are voided,Unknown,you should also use that time to sleep aswell,Unknown,Money is also a necessity,Unknown,Here's a few+500,Unknown,they are used to hire decipherers like me,Unknown,you can come back to me if you have any words you don't know what to do with it and I'll answer to the best of my knowledge`",
	"tutorialno":"Unknown=Unknown,don't lie to me,Unknown,do you want to become a spy?>Yes<tutorialyes>No<tutorialno",
	"tutorialdecipher":"Unknown=Unknown,1000 upfront,Unknown,you can choose to pay me and I'll guarantee that the code is correct,Unknown,or you can try your luck with the others>Ok I'll pay<tutorialdecipheryes>Then I guess I'll test my luck<tutorialnodecipher",
	"tutorialnodecipher":"Unknown=Unknown,your choice,Unknown,anything else?`",
	"tutorialdecipheryes":"Unknown=Unknown,done+-1000,Unknown,give me a sec,Unknown,.....,Unknown,.....,Unknown,The code is &,Unknown,Anything else?`",
	"tutorialdecipheryesThe best in the world":"The best in the world=The best in the world,done+-840,Unknown,this will only take a moment,Unknown,.....,Unknown,.....,Unknown,The code is &,Unknown,Anything else?`",
	"tutorialdecipheryesmighty cipher":"mighty cipher=mighty cipher,done+-600,Unknown,this will only take a moment,Unknown,.....,Unknown,.....,Unknown,The code is &,Unknown,Anything else?`",
	"tutorialdecipheryesdeluxe bitcoin":"deluxe bitcoin=deluxe bitcoin,done+-400,Unknown,this will only take a moment,Unknown,.....,Unknown,.....,Unknown,The code is &,Unknown,Anything else?`",
	"tutorialdecipheryesnoisy carer":"noisy carer=noisy carer,done+-80,Unknown,this will only take a moment,Unknown,.....,Unknown,.....,Unknown,The code is &,Unknown,Anything else?`",
	"tutorialdecipherer":"Unknown=Unknown,give me a sec`",
	"The best in the world":"Unknown=Unknown,give me a sec*TBITW",
	"TBITW":"The best in the world=The best in the world,you called?,me,I need your help in deciphering,The best in the world,sure,The best in the world,give me a code and I'll see what I can do`",
	"mighty cipher":"Unknown=Unknown,give me a sec*MC",
	"MC":"mighty cipher=mighty cipher,Got a text saying you need help?,me,I need your help in deciphering,The best in the world,sure,The best in the world,gimme the code you wanna decipher`",
	"deluxe bitcoin":"Unknown=Unknown,give me a sec*DB",
	"DB":"deluxe bitcoin=deluxe bitcoin,You need helping?,me,I need your help in deciphering,The best in the world,sure,The best in the world,let's see what codes you have`",
	"noisy carer":"Unknown=Unknown,give me a sec*NC",
	"NC":"noisy carer=noisy carer,what's up?,me,I need your help in deciphering,The best in the world,bet,The best in the world,give me the code first fam`",
	}	
,
"keywords":["22 April", "spy", "Dinnerbone Lite"],
"Codes":{"IS3eY00":"Hopscotch","Ur321":"HorseInMyFoot","X7yZ99": "Blueberry"},
"Gibberish":["UrDown", "ImagineNothing","GetOut","NothinghamHo","ChristmasDown","SeeYaBetter","GetUrOwnData"],
"decipherers":{"The best in the world":210,"mighty cipher":150,"deluxe bitcoin":100,"noisy carer":20},
"keywords_gotten":[],
"read":[]}
var data: Dictionary


func checkkeyword(content: String) -> String:
	var tempcontent = content
	var keywords = data["keywords"]
	for i in keywords:
		var tempkeyword = tempcontent.to_upper().find(i.to_upper())
		if tempkeyword >= 0:
			var temp = "[url="+ i +"]"
			tempcontent = tempcontent.insert(tempkeyword, temp)
			tempcontent = tempcontent.insert(tempkeyword + len(temp) + len(i), "[/url]")
	for i in data["searches"].keys():
		var tempkeyword = tempcontent.to_upper().find(i.to_upper())
		if tempkeyword >= 0:
			var temp = "[url="+ i +"]"
			tempcontent = tempcontent.insert(tempkeyword, temp)
			tempcontent = tempcontent.insert(tempkeyword + len(temp) + len(i), "[/url]")
	for i in data["Codes"].keys():
		var tempkeyword = tempcontent.to_upper().find(i.to_upper())
		if tempkeyword >= 0:
			var temp = "[url="+ i +"]"
			tempcontent = tempcontent.insert(tempkeyword, temp)
			tempcontent = tempcontent.insert(tempkeyword + len(temp) + len(i), "[/url]")
	for i in data["Codes"].values():
		var tempkeyword = tempcontent.to_upper().find(i.to_upper())
		if tempkeyword >= 0:
			var temp = "[url="+ i +"]"
			tempcontent = tempcontent.insert(tempkeyword, temp)
			tempcontent = tempcontent.insert(tempkeyword + len(temp) + len(i), "[/url]")
	for i in data["Gibberish"]:
		var tempkeyword = tempcontent.to_upper().find(i.to_upper())
		if tempkeyword >= 0:
			var temp = "[url="+ i +"]"
			tempcontent = tempcontent.insert(tempkeyword, temp)
			tempcontent = tempcontent.insert(tempkeyword + len(temp) + len(i), "[/url]")
	for i in data["decipherers"].keys():
		var tempkeyword = tempcontent.to_upper().find(i.to_upper())
		if tempkeyword >= 0:
			var temp = "[url="+ i +"]"
			tempcontent = tempcontent.insert(tempkeyword, temp)
			tempcontent = tempcontent.insert(tempkeyword + len(temp) + len(i), "[/url]")
	
	return tempcontent


func _ready() -> void:
	data = load_data()
	get_tree().node_added.connect(_on_node_added)

func reset():
	data["money"] -= 100
	for i in data["people_known"]:
		if i.keys()[0] == "Unknown" or data["decipherers"].keys().has(i):
			continue
		data["people_known"].erase(i)
	data["Email"] = {}
	data["read"] = []
	for i in range(randi_range(1, 1 + data["reputation"]/100)):
		var random = data["Quest"].keys().pick_random()
		data["Email"][random] = data["Quest"][random]
	if data["money"] < 0:
		end = true
		Transtition.end()
func _on_node_added(node: Node) -> void:
	if node is RichTextLabel:
		_setup_new_richtextlabel(node)

func _setup_new_richtextlabel(label: RichTextLabel) -> void:
	label.meta_clicked.connect(func(meta):
		_on_any_link_clicked(label, meta))
	label.bbcode_enabled = true



func _on_any_link_clicked(label: RichTextLabel, meta) -> void:
	var instance = notifs.instantiate()
	if data["keywords_gotten"].has(meta):
		instance.get_node("margin").get_node("text").text = '"'+ meta+'"' + " is already in wordbox!"
	else:
		data["keywords_gotten"].append(meta)
		instance.get_node("margin").get_node("text").text = '"'+ meta+'"' + " added into wordbox"
	$"../computer/notifbox".add_child(instance)
	

func override():
	data = default.duplicate(true)
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
