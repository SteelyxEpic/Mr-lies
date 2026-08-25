extends Node2D

@onready var screen: Sprite2D = $Pc/Screen
@onready var onButton: TextureButton = $Pc/TextureButton
@onready var camera: Camera2D = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	onButton.pressed.connect(on)
	if Global.shut:
		Global.shut = false
		off()


func on():
	get_tree().create_tween().tween_property(camera, "position", screen.global_position, 2)
	get_tree().create_tween().tween_property(camera, "zoom", Vector2(1.2, 1.2), 2)
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/computer.tscn") 
	

func off():
	camera.position = screen.global_position
	camera.zoom = Vector2(1.2, 1.2)
	get_tree().create_tween().tween_property(camera, "position", Vector2(1, 304), 2)
	get_tree().create_tween().tween_property(camera, "zoom", Vector2(.275, .275), 2)
	await get_tree().create_timer(2).timeout
	
