extends CardState

const DRAG_MINIMUM_THRESHOLD := 0.05
var minimum_drag_time_elapsed := false

func enter() -> void:
	var ui_laryer := get_tree().get_first_node_in_group("ui_layer")
	
	if ui_laryer:
		card_ui.reparent(ui_laryer)
	
	card_ui.panel.set("theme_override_styles/panel",card_ui.CARD_DRAGGING_STYLEBOX)
	Events.card_drag_started.emit(card_ui)
	minimum_drag_time_elapsed = false
	var threshould_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD,false)
	threshould_timer.timeout.connect(func():minimum_drag_time_elapsed = true)


func on_input(event:InputEvent) -> void:
	var single_targeted := card_ui.card.is_single_targeted()
	var mouse_motion := event is InputEventMouseMotion
	var cancel := event.is_action_pressed("right_mouse")
	var cofirm := event.is_action_pressed("left_mouse") or event.is_action_released("left_mouse")
	
	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
	
	if single_targeted and mouse_motion and card_ui.targets.size() >0 :
		transition_requested.emit(self,CardState.State.AIMING)
		return
		
	if cancel:
		transition_requested.emit(self,CardState.State.BASE)
	elif minimum_drag_time_elapsed and cofirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self,CardState.State.RELEASED)

func exit() -> void:
	Events.card_drag_ended.emit(card_ui)
 
