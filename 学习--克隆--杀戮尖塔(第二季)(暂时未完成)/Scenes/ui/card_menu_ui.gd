class_name CardMenuUI
extends CenterContainer

signal tooltip_request(card:Card)

const CARD_BASE_STYLEBOX = preload("res://Scenes/card_ui/card_base_stylebox.tres")
const CARD_HOVER_STYLEBOX = preload("res://Scenes/card_ui/card_hover_stylebox.tres")

@onready var visuals: CardVisuals = $Visuals

@export var card:Card :
	set(v):
		if not is_node_ready():
			await ready
		card = v
		visuals.card = card

func _on_visuals_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		tooltip_request.emit(card)


func _on_visuals_mouse_entered() -> void:
	visuals.panel.set("theme_override_styles/panel",CARD_HOVER_STYLEBOX)


func _on_visuals_mouse_exited() -> void:
	visuals.panel.set("theme_override_styles/panel",CARD_BASE_STYLEBOX)
