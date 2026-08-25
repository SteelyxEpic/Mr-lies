extends Node2D

@onready var screen: Sprite2D = $screen
@onready var mail: TextureButton = $screen/mail
@onready var web: TextureButton = $screen/web
@onready var chat: TextureButton = $screen/chat
@onready var word:RichTextLabel = $word
@onready var email:Sprite2D = $Email
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().create_tween().tween_property(screen, "modulate", Color(1.0, 1.0, 1.0, 1.0), 2)
	mail.mouse_entered.connect(func():
		word.show()
		word.text = "Mail")
	mail.mouse_exited.connect(func():
		word.hide())
	web.mouse_entered.connect(func():
		word.show()
		word.text = "Web")
	web.mouse_exited.connect(func():
		word.hide())
	chat.mouse_entered.connect(func():
		word.show()
		word.text = "Chat")
	chat.mouse_exited.connect(func():
		word.hide())

func emailopen():
	get_tree().create_tween().tween_property(email, "position", Vector2(590, 333), 0.2)
	get_tree().create_tween().tween_property(email, "scale", Vector2(1, 1), 0.2)
	

func emailclose():
	get_tree().create_tween().tween_property(email, "position", mail.global_position + mail.size/2, 0.2)
	get_tree().create_tween().tween_property(email, "scale", Vector2(0, 0), 0.2)
func shutdown():
	get_tree().create_tween().tween_property(screen, "modulate", Color(0, 0, 0, 1.0), 1)
	Global.shut = true
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn") 

func _process(delta: float) -> void:
	word.position = get_global_mouse_position() + Vector2(2, 2)
