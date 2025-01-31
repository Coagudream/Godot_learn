class_name BattleUI
extends CanvasLayer

@onready var hand: Hand = $Hand
@onready var mana_ui: ManaUI = $ManaUI
@onready var end_turn_button: Button = %EndTurnButton


@export var char_stats:CharacterStats:
	set(v):
		char_stats = v
		
		mana_ui.char_stats = char_stats
		hand.char_stats = char_stats

func _ready() -> void:
	Events.player_hand_drawn.connect(_on_player_hand_drawn)
	end_turn_button.pressed.connect(_on_end_turn_button)

func _on_player_hand_drawn() -> void:
	end_turn_button.disabled = false

##按下回合结束按钮后调用的函数
func _on_end_turn_button() -> void:
	end_turn_button.disabled = true
	Events.player_turn_ended.emit()
	
