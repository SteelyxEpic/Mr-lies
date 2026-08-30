extends PanelContainer


func done():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, 1)
	await tween.finished
	queue_free()
