class_name CardVisuals
extends Control

@export var card: Card :
	set(v):
		if not is_node_ready():
			await ready
		card = v
		cost.text = str(card.cost)
		icon.texture = card.icon
		rarity.modulate = Card.RARITY_COLORS[card.rarity]

@onready var panel: Panel = $Panel
@onready var cost: Label = $cost
@onready var icon: TextureRect = $Icon
@onready var rarity: TextureRect = $Rarity
