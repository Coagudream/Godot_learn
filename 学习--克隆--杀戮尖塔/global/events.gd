extends Node

#卡片事件组
signal card_drag_started(card_ui: CardUI)  ##卡牌拖动开始
signal card_drag_ended(card_ui: CardUI)    ##卡牌拖动结束
signal card_aim_started(card_ui: CardUI)   ##卡牌瞄准开始
signal card_aim_ended(card_ui: CardUI)     ##卡牌瞄准结束
signal card_play(card: Card)               ##卡牌打出
signal card_tooltip_requseted(card:Card)   ##卡牌提示显示
signal tooltip_hide_requested              ##卡牌提示隐藏


#玩家玩法
signal player_hand_drawn      ##玩家抽牌结束
signal player_hand_discarded  ##玩家弃牌结束
signal player_turn_ended      ##玩家回合结束
signal player_hit             ##玩家掉血
signal player_died            ##玩家死亡

#敌人事件
signal enemy_action_completed(enemy:Enemy)  ##敌人的行动完成时
signal enemy_turn_ended  ##敌人回合结束时

#战斗结束评估请求
signal battle_over_requested(text:String, type:BatleOverPanel.Type)
