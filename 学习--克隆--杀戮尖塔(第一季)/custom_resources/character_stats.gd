class_name CharacterStats
extends Stats

@export var staring_deck: CardPile
@export var cards_per_turn: int
@export var max_mana: int

var mana:int :
	set(v):
		mana = v
		stats_changed.emit()


var deck: CardPile ##当前牌堆
var discard: CardPile ##弃牌堆
var draw_pile: CardPile ##抽牌堆

##重置法力值
func reset_mana() -> void:
	self.mana = max_mana

##是否能打出牌的函数
func can_play_card(card:Card) -> bool:
	return mana >= card.cost


##造成伤害函数
func take_damage(damage:int) -> void:
	if damage <= 0:
		return
	var initial_health = health
	super.take_damage(damage)
	
	if initial_health > health:
		Events.player_hit.emit()
	



##初始化资源
func create_instance() -> Resource:
	var instance: Stats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	instance.reset_mana()
	instance.deck = instance.staring_deck.duplicate()
	instance.draw_pile = CardPile.new()
	instance.discard = CardPile.new()
	return instance
