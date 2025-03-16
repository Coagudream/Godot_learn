class_name BattleReward
extends Control

const REWARD_BUTTON = preload("res://Scenes/ui/reward_button.tscn")

const GOLD_ICON = preload("res://art/gold.png")
const GOLD_TEXT = "%s 金币"
const CARD_ICON = preload("res://art/rarity.png")
const CARD_TEXT = "选择新卡牌"

@export var run_stats:RunStats
@onready var rewards: VBoxContainer = %Rewards

func _ready() -> void:
	for node:Node in rewards.get_children():
		node.queue_free()
		
	run_stats = RunStats.new()
	
	run_stats.gold_changed.connect(func(): print("%s" %run_stats.gold))

##奖励金币初始化--运行一次
func add_gold_reward(amount:int) -> void:
	var gold_reward := REWARD_BUTTON.instantiate()
	gold_reward.reward_icon = GOLD_ICON
	gold_reward.reward_text = GOLD_TEXT % amount
	gold_reward.pressed.connect(_on_gold_reward_taken.bind(amount))
	rewards.add_child.call_deferred(gold_reward)


func _on_gold_reward_taken(amount:int) -> void:
	if not run_stats: 
		return
	
	run_stats.gold += amount

func _on_back_button_pressed() -> void:
	Events.battle_reward_exited.emit()
