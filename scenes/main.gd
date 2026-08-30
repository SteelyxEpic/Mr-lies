extends Node2D

@onready var screen: Sprite2D = $Pc/Screen
@onready var onButton: TextureButton = $Pc/TextureButton
@onready var camera: Camera2D = $Camera2D
@onready var alarm: RichTextLabel = $alarmtext
@onready var no: RichTextLabel = $no
var notween:Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$money.text = "$" + str(Global.data["money"])
	Transtition.timecall.connect(func():
		var times = Transtition.times
		alarm.text = str(floor(times/60)) + ":" + "%02d" % (times%60))
	onButton.pressed.connect(on)
	if Global.shut:
		Global.shut = false
		off()


func on():
	Transtition.times += 30
	if Transtition.times < 480:
		no.modulate = Color(1.0, 1.0, 1.0, 1.0)
		if notween:
			notween.kill()
		notween = get_tree().create_tween()
		notween.tween_property(no,"modulate:a", 0, 1)
	else:
		get_tree().create_tween().tween_property(camera, "position", screen.global_position, 2)
		get_tree().create_tween().tween_property(camera, "zoom", Vector2(1.2, 1.2), 2)
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://scenes/computer.tscn") 
	

func off():
	Transtition.times += 30
	$money.text = "$" + str(Global.data["money"])
	camera.position = screen.global_position
	camera.zoom = Vector2(1.2, 1.2)
	get_tree().create_tween().tween_property(camera, "position", Vector2(1, 304), 2)
	get_tree().create_tween().tween_property(camera, "zoom", Vector2(.275, .275), 2)
	await get_tree().create_timer(2).timeout


func sleep():
	Transtition.times = 480
	get_tree().create_tween().tween_property(self, "modulate", Color(0.0, 0.0, 0.0, 1.0), 2)
	await get_tree().create_timer(2).timeout
	$money.text = "$" + str(Global.data["money"])
	if Global.data["money"] < 100:
		print("not enough")
	else:
		get_tree().create_tween().tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 1.0), 2)
