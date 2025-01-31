extends CardState

var player: bool

func enter() -> void:
	player = false
	
	if not card_ui.targets.is_empty():
		Events.tooltip_hide_requested.emit()
		player = true
		card_ui.play()
	
	
func on_input(_event: InputEvent) -> void:
	if player:
		return
	transition_requested.emit(self,CardState.State.BASE)
	
	
