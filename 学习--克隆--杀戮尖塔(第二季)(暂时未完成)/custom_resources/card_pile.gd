class_name CardPile
extends Resource

##定义牌库内数量改变信号
signal card_pile_size_changed(cards_amount:int)

@export var cards:Array[Card] = []

func empty() -> bool :
	return cards.is_empty()

##抽第一牌
func draw_card() -> Card:
	var card = cards.pop_front()
	card_pile_size_changed.emit(cards.size())
	return card

##添加牌
func add_card(card:Card) -> void:
	cards.append(card)
	card_pile_size_changed.emit(cards.size())

##随机洗牌
func shuffle() -> void:
	cards.shuffle()

##清理卡牌
func clear() -> void:
	cards.clear()
	card_pile_size_changed.emit(cards.size())

#覆盖虚函数
func _to_string() -> String:
	var _card_strings: PackedStringArray = []
	for i in range(cards.size()):
		_card_strings.append( "%s: %s" % [i+1, cards[i].id])
	
	return "\n".join(_card_strings)
