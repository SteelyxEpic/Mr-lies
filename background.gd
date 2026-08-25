extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	size = get_viewport_rect().size + Vector2(20, 20)
	var offsetx = remap(get_viewport().get_mouse_position().x, 0, get_viewport_rect().size.x, -20, 0)
	var offsety = remap(get_viewport().get_mouse_position().y, 0, get_viewport_rect().size.y, -20, 0)
	position = Vector2(offsetx, offsety)
	for child in get_children():
		child.position = Vector2(offsetx, offsety)
	
