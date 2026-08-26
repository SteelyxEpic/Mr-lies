extends Button

@onready var alert:Sprite2D = $Alert


func read(yes: bool):
	alert.visible = yes
