class_name Hand
extends HBoxContainer

@onready var card_ui := preload("res://Scenes/card_ui/card_ui.tscn")

@export var char_stats: CharacterStats




##实例化卡牌
func add_card(card: Card) -> void:
	var new_card_ui :CardUI = card_ui.instantiate()
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	new_card_ui.card = card
	new_card_ui.parent = self
	new_card_ui.char_stats = char_stats

##丢弃卡牌
func discrad_card(card_ui:CardUI) -> void:
	card_ui.queue_free()

##锁定卡牌
func discrad_hand() -> void:
	for card_ui in get_children():
		card_ui.disabled = true

##卡牌重新父化函数
func _on_card_ui_reparent_requested(child:CardUI):
	child.disabled = true
	child.reparent(self)
	
	var new_index := clampi(child.original_index,0,get_child_count())
	move_child.call_deferred(child,new_index)
	child.set_deferred("disabled",false)
