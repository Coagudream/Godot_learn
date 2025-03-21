extends Node2D

@onready var battle_ui: BattleUI = $BattleUI
@onready var player_handler: PlayerHandler = $PlayerHandler
@onready var player: Player = $Player
@onready var enemy_handler: EnemyHandler = $EnemyHandler

@export var char_stats: CharacterStats
@export var music: AudioStream

func _ready() -> void:
	var new_stats: CharacterStats = char_stats.create_instance()
	player.stats = new_stats
	battle_ui.char_stats = new_stats
	
	enemy_handler.child_order_changed.connect(_on_child_order_changed)
	Events.enemy_turn_ended.connect(_on_enemy_turn_ended)
	Events.player_died.connect(_on_player_died)
	Events.player_turn_ended.connect(player_handler.end_turn)
	Events.player_hand_discarded.connect(enemy_handler.start_turn)
	start_battle(new_stats)
	


##开始战斗
func start_battle(stats:CharacterStats) -> void:
	get_tree().paused = false
	MusicPlayer.play(music,true)
	enemy_handler.reset_enemy_actions()
	player_handler.start_battle(stats)
	
##敌人回合结束的处理
func _on_enemy_turn_ended() -> void:
	player_handler.start_turn()
	enemy_handler.reset_enemy_actions()


func _on_child_order_changed() -> void:
	if enemy_handler.get_child_count() == 0:
		Events.battle_over_requested.emit("胜利！",BatleOverPanel.Type.WIN)

func _on_player_died() -> void:
	Events.battle_over_requested.emit("失败！",BatleOverPanel.Type.LOSE)
