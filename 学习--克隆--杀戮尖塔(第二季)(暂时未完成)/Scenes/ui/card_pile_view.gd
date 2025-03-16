class_name CardPileView
extends Control

const CARD_MENU_UI = preload("res://Scenes/ui/card_menu_ui.tscn")

@onready var title: Label = %Title
@onready var cards: GridContainer = %Cards
@onready var back_button: Button = %BackButton
@onready var card_tooltip_popup: CardTooltipPopup = %CardTooltipPopup

@export var card_pile:CardPile


func _ready() -> void:
	back_button.pressed.connect(hide)
	
	for child:Node in cards.get_children():
		child.queue_free()
	
	card_tooltip_popup.hide_tooltip()


##如果卡牌提示是显示的，则在按下ESC键时关闭
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if card_tooltip_popup.visible:
			card_tooltip_popup.hide_tooltip()
		else:
			hide()



func show_current_view(new_title:String,randomized:bool = false) -> void:
	for card:Node in cards.get_children():
		card.queue_free()
	
	card_tooltip_popup.hide_tooltip()
	title.text = new_title
	
	#为了保证cards的子节点清除（queue_free()）完毕,所以在帧末尾进行
	_updata_view.call_deferred(randomized)


func _updata_view(randomized:bool) -> void:
	if not card_pile: return
	
	#保证不影响卡组，进行拷贝
	var all_cards := card_pile.cards.duplicate()
	
	if randomized:
		all_cards.shuffle()
	
	for card:Card in all_cards:
		#在代码中实例化场景，对根节点（类）进行初始设置
		var new_card:Node = CARD_MENU_UI.instantiate() as CardMenuUI
		new_card.card = card
		new_card.tooltip_request.connect(card_tooltip_popup.show_tooltip)
		cards.add_child(new_card)
	
	show()
