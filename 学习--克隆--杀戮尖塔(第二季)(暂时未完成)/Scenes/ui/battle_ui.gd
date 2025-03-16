class_name BattleUI
extends CanvasLayer

@onready var hand: Hand = $Hand
@onready var mana_ui: ManaUI = $ManaUI
@onready var end_turn_button: Button = %EndTurnButton
@onready var darw_pile_oprner: CardPileOpener = %DarwPileOprner
@onready var discard_pile_oprner: CardPileOpener = %DiscardPileOprner
@onready var darw_plie_view: CardPileView = %DarwPlieView
@onready var discard_plie_view: CardPileView = %DiscardPlieView



@export var char_stats:CharacterStats:
	set(v):
		char_stats = v
		
		mana_ui.char_stats = char_stats
		hand.char_stats = char_stats

func _ready() -> void:
	Events.player_hand_drawn.connect(_on_player_hand_drawn)
	end_turn_button.pressed.connect(_on_end_turn_button)
	darw_pile_oprner.pressed.connect(darw_plie_view.show_current_view.bind("抽牌堆",true))
	discard_pile_oprner.pressed.connect(discard_plie_view.show_current_view.bind("弃牌堆"))


##链接抽牌堆和弃牌堆的ui通知
func initialze_card_pile_ui() -> void:
	darw_pile_oprner.card_pile = char_stats.draw_pile
	darw_plie_view.card_pile = char_stats.draw_pile
	discard_pile_oprner.card_pile = char_stats.discard
	discard_plie_view.card_pile = char_stats.discard


func _on_player_hand_drawn() -> void:
	end_turn_button.disabled = false

##按下回合结束按钮后调用的函数
func _on_end_turn_button() -> void:
	end_turn_button.disabled = true
	Events.player_turn_ended.emit()
	
