extends Node2D

@onready var screen: Sprite2D = $screen
@onready var mail: TextureButton = $screen/mail
@onready var web: TextureButton = $screen/web
@onready var chat: TextureButton = $screen/chat
@onready var sitemail: Node2D = $site/Email
@onready var siteweb: Node2D = $site/Web
@onready var sitechat: Node2D = $site/Chat
@onready var closes: TextureButton = $site/close
@onready var word:RichTextLabel = $word
@onready var email:Sprite2D = $site
@onready var emailbg:Texture2D = preload("res://email.png")
@onready var chatbg:Texture2D = preload("res://chatbg.png")
@onready var webbg:Texture2D = preload("res://webbg.png")
var temp
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().create_tween().tween_property(screen, "modulate", Color(1.0, 1.0, 1.0, 1.0), 2)
	mail.mouse_entered.connect(func():
		word.show()
		word.text = "Mail")
	mail.mouse_exited.connect(func():
		word.hide())
	mail.pressed.connect(func():
		email.texture = emailbg
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
		sitechat.hide()
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
		sitechat.show()
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
	

func close(icon):
	var emailtween = get_tree().create_tween().set_parallel(true)
	emailtween.tween_property(email, "position", icon.global_position + (icon.size/2*icon.scale), 0.2)
	emailtween.tween_property(email, "scale", Vector2(0, 0), 0.2)
func shutdown():
	get_tree().create_tween().tween_property(screen, "modulate", Color(0, 0, 0, 1.0), 1)
	Global.shut = true
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn") 

func _process(delta: float) -> void:
	word.position = get_global_mouse_position() + Vector2(2, 2)
