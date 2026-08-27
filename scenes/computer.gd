extends Node2D

@onready var screen: Sprite2D = $screen
@onready var mail: TextureButton = $screen/mail
@onready var web: TextureButton = $screen/web
@onready var chat: TextureButton = $screen/chat
@onready var sitemail: Node2D = $site/Email
@onready var siteweb: Node2D = $site/Web
@onready var sitechat: Node2D = $site/Chat
@onready var sitewebsearch: Node2D = $site/Websearch
@onready var sitemediaxnews: Node2D = $site/Mediaxwork
@onready var closes: TextureButton = $site/close
@onready var word:RichTextLabel = $word
@onready var email:Sprite2D = $site
@onready var emailbg:Texture2D = preload("res://email.png")
@onready var chatbg:Texture2D = preload("res://chatbg.png")
@onready var webbg:Texture2D = preload("res://webbg.png")
@onready var websearchbg:Texture2D = preload("res://websearch.png")
@onready var mediabg:Texture2D = preload("res://media.png")
@onready var newsbg:Texture2D = preload("res://newsbg.png")
@onready var searchprefab: PackedScene = preload("res://searches.tscn")
@onready var peopleprefab: PackedScene = preload("res://peoplebox.tscn")
var temp
var prev:String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().create_tween().tween_property(screen, "modulate", Color(1.0, 1.0, 1.0, 1.0), 2)
	mail.mouse_entered.connect(func():
		word.show()
		word.text = "Mail")
	mail.mouse_exited.connect(func():
		word.hide())
	mail.pressed.connect(func():
		emailcheck()
		email.texture = emailbg
		sitemediaxnews.hide()
		sitewebsearch.hide()
		sitechat.hide()
		sitemail.show()
		siteweb.hide()
		open(mail)
		)
	web.mouse_entered.connect(func():
		word.show()
		word.text = "Web")
	web.mouse_exited.connect(func():
		word.hide())
	web.pressed.connect(func():
		email.texture = webbg
		open(web)
		sitemediaxnews.hide()
		sitechat.hide()
		sitewebsearch.hide()
		sitemail.hide()
		siteweb.show())
	chat.mouse_entered.connect(func():
		word.show()
		word.text = "Chat")
	chat.mouse_exited.connect(func():
		word.hide())
	chat.pressed.connect(func():
		email.texture = chatbg
		open(chat)
		sitemediaxnews.hide()
		sitechat.show()
		sitewebsearch.hide()
		sitemail.hide()
		siteweb.hide())

func open(icon):
	email.position =  icon.global_position + (icon.size/2*icon.scale)
	var emailtween = get_tree().create_tween().set_parallel(true)
	emailtween.tween_property(email, "position", Vector2(590, 333), 0.2)
	emailtween.tween_property(email, "scale", Vector2(1, 1), 0.2)
	if temp:
		closes.pressed.disconnect(temp)
	temp = func():
		close(icon)
	closes.pressed.connect(temp)
	
func emailcheck():
	for i in sitemail.get_node("ScrollContainer/VBoxContainer").get_children():
		i.queue_free()
	for i in Global.data["Email"].keys():
		var instance = peopleprefab.instantiate()
		instance.text = i
		sitemail.get_node("ScrollContainer/VBoxContainer").add_child(instance)
		instance.pressed.connect(func():
			changeemail(i))

func changeemail(key:String):
	var accept: Button = sitemail.get_node("accept")
	var content = Global.data["Email"][key].split("|")
	sitemail.get_node("Title").text = key
	sitemail.get_node("content").text = content[0]
	if Global.data["read"].has(content[1]):
		accept.disabled = true
	else:
		accept.disabled = false
	for connection in accept.pressed.get_connections():
		accept.pressed.disconnect(connection.callable)
	accept.pressed.connect(func():
		acceptemail(content[1])
		accept.disabled = true
		)
func acceptemail(key:String):
	var content = Global.data["text"][key].split("=")
	var temp: Dictionary = {content[0]: "", "queue": content[1]}
	var new = true
	for i in Global.data["people_known"]:
		if i.keys()[0] == content[0]:
			i["queue"] += content[1]
			new = false
			break
	if new:
		Global.data["people_known"].append(temp)
	sitechat.recheck()
	Global.data["read"].append(key)
		
func close(icon):
	var emailtween = get_tree().create_tween().set_parallel(true)
	emailtween.tween_property(email, "position", icon.global_position + (icon.size/2*icon.scale), 0.2)
	emailtween.tween_property(email, "scale", Vector2(0, 0), 0.2)
func shutdown():
	get_tree().create_tween().tween_property(screen, "modulate", Color(0, 0, 0, 1.0), 1)
	Global.shut = true
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn") 

func search(test:String = "", reload: bool = true):
	var searches: String = ""
	if test == "":
		if sitewebsearch.visible:
			searches = sitewebsearch.get_node("searchbar").text
		else:
			searches = siteweb.get_node("searchbar").text
	else:
		searches = test
	email.texture = websearchbg
	siteweb.hide()
	sitewebsearch.show()
	var loading: TextureRect = sitewebsearch.get_node("loading")
	var search: Button = sitewebsearch.get_node("search")
	var searcharea: ScrollContainer = sitewebsearch.get_node("searcharea")
	searcharea.hide()
	if reload:
		search.disabled = true
		loading.show()
		loading.rotation_degrees = 0
		var tween:Tween = get_tree().create_tween()
		tween.tween_property(loading, "rotation_degrees", 360, 2)
		await tween.finished
		loading.hide()
		search.disabled = false
	searcharea.show()
	for i in searcharea.get_child(0).get_children():
		if i.name != "nomore":
			i.queue_free()
	var query = {}
	for i in Global.data["searches"].keys():
		if searches.to_upper().contains(i.to_upper()):
			query = Global.data["searches"][i]
			break
	for i in query.keys():
		for x in query[i].keys():
			var instance = searchprefab.instantiate()
			instance.text = x
			instance.pressed.connect(func():
				prev = searches
				contentadd(i, x, query[i][x]))
			searcharea.get_node("VBoxContainer").add_child(instance)
	searcharea.get_node("VBoxContainer").move_child(searcharea.get_node("VBoxContainer").get_node("nomore"), -1)
	sitewebsearch.get_node("searchbar").text = searches
	siteweb.get_node("searchbar").text = ""
	
func returns():
	sitemediaxnews.hide()
	search(prev, false)
func contentadd(type:String, title:String, content:String):
	sitemediaxnews.show()
	sitewebsearch.hide()
	sitemediaxnews.get_node("content").text = content
	if type == "news":
		sitemediaxnews.get_node("news").text = title
		sitemediaxnews.get_node("news").show()
		sitemediaxnews.get_node("media").hide()
		email.texture = newsbg
	elif type == "Media":
		sitemediaxnews.get_node("media").text = title
		sitemediaxnews.get_node("media").show()
		sitemediaxnews.get_node("news").hide()
		email.texture = mediabg
	
func _process(delta: float) -> void:
	word.position = get_global_mouse_position() + Vector2(2, 2)
