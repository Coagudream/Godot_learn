extends Control


func _on_button_pressed() -> void:
	Events.campifire_exited.emit()
