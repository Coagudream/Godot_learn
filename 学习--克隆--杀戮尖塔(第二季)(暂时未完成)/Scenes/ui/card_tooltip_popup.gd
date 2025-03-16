class_name CardTooltipPopup
extends Control


const CARD_MENU_UI = preload("res://Scenes/ui/card_menu_ui.tscn")

@onready var tooltip_card: CenterContainer = %TooltipCard
@onready var card_description: RichTextLabel = %CardDescription


func _ready() -> void:
	for card:CardMenuUI in tooltip_card.get_children():
		card.queue_free()
		

##展示工具提示（传入card）
func show_tooltip(card:Card) -> void:
	var new_card := CARD_MENU_UI.instantiate() as CardMenuUI
	tooltip_card.add_child(new_card)
	
	new_card.card = card
	new_card.tooltip_request.connect(hide_tooltip.unbind(1))
	card_description.text = "[center]%s[/center]"  %card.tooltip_text
	show()


##隐藏工具提示
func hide_tooltip() -> void:
	#安全检查
	if not visible:
		return
		
	for card:CardMenuUI in tooltip_card.get_children():
		card.queue_free()
	hide()

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		hide_tooltip()
