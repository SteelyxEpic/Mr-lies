extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func main():
	Global.override()
	Transtition.times = 480
	Transtition.timer.start()
	Transtition.trans("main")
