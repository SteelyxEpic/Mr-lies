extends Node2D

var tween: Tween
var transtitioning: bool
@onready var transs:Sprite2D = $Transtition
var zoom = 1

func trans(scene: String):
	transtitioning = true
	zoom = 1
	show()
	
	var current_cam = get_viewport().get_camera_2d()
	position = Vector2(600, 350)
	if current_cam:
		position.y = current_cam.global_position.y
		position.x = current_cam.global_position.x
		zoom = current_cam.zoom.x
		scale = Vector2(1/zoom, 1/zoom)
		
	tween = create_tween()
	tween.tween_property(transs, "position:x", 0, 1)
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://scenes/"+ scene + ".tscn") 
	scale = Vector2(10, 10)
	await get_tree().process_frame
	await get_tree().process_frame
	current_cam = get_viewport().get_camera_2d()
	zoom = 1
	position = Vector2(600, 350)
	if current_cam:
		position.y = current_cam.global_position.y
		position.x = current_cam.global_position.x
		zoom = current_cam.zoom.x
		scale = Vector2.ONE / zoom
	tween.kill()
	tween = create_tween()
	tween.tween_property(transs, "position:x", -1600, 1)
	await get_tree().create_timer(1).timeout
	hide()
	transs.position.x = 1600
	transtitioning = false
	
	
