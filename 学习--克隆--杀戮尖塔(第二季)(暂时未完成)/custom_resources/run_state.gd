class_name RunStats
extends Resource

signal gold_changed

##初始金币值
const STARTING_GOLD := 70
##基础卡牌奖励
const BASE_CARD_REWARDS := 3
#卡牌权重
const BASE_COMMON_WEIGHT := 6.0
const BASE_UNCOMMON_WEIGHT := 3.7
const BASE_RARE_WEIGHT := 0.3

@export var gold := STARTING_GOLD :
	set(v):
		gold = v
		gold_changed.emit()

@export var card_rewards := BASE_CARD_REWARDS
@export_range(0.0, 10.0) var common_weight := BASE_COMMON_WEIGHT
@export_range(0.0, 10.0) var uncommon_weight := BASE_UNCOMMON_WEIGHT
@export_range(0.0, 10.0) var rare_weight := BASE_RARE_WEIGHT

func reset_weights() -> void:
	common_weight = BASE_COMMON_WEIGHT
	uncommon_weight = BASE_UNCOMMON_WEIGHT
	rare_weight = BASE_RARE_WEIGHT
