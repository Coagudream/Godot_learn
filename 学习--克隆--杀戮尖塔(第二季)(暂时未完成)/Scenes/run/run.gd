class_name Run
extends Node

const MAP_SCENE = preload("res://Scenes/map/map.tscn")
const REWARDS_SCENE = preload("res://Scenes/rewards/rewards.tscn")
const SHOP_SCENE = preload("res://Scenes/shop/shop.tscn")
const TREASURE_SCENE = preload("res://Scenes/treasure/treasure.tscn")
const BATTLE_SCENE = preload("res://Scenes/battle/battle.tscn")
const CAMPFIRE_SCENE = preload("res://Scenes/campfire/campfire.tscn")

@onready var deck_botten: CardPileOpener = %DeckBotten
@onready var deck_view: CardPileView = %DeckView
@onready var map_button: Button = %MapButton
@onready var buttle_button: Button = %ButtleButton
@onready var treasure_button: Button = %TreasureButton
@onready var rewards_button: Button = %RewardsButton
@onready var shop_button: Button = %ShopButton
@onready var campfire_button: Button = %CampfireButton
@onready var current_view: Node = $CurrentView
@onready var gold_ui: GoldUI = %GoldUI


@export var run_startup:RunStartup

var stats:RunStats
var character: CharacterStats

func _ready() -> void:
	if not run_startup:
		return
		
	match  run_startup.type:
		RunStartup.Type.NEW_RUN:
			character = run_startup.picked_character.create_instance()
			_start_run()
		RunStartup.Type.CONTINUED_RUN:
			print("RUN")
		
	


##开始新游戏
func _start_run() -> void:
	stats = RunStats.new()
	_setup_event_connections()
	_setup_top_bar()
	print("TODO：随机化新地图")

func _setup_event_connections() -> void:
	#链接事件总线
	Events.battle_own.connect(_change_view.bind(REWARDS_SCENE))
	Events.battle_reward_exited.connect(_change_view.bind(MAP_SCENE))
	Events.campifire_exited.connect(_change_view.bind(MAP_SCENE))
	Events.map_exited.connect(_on_map_exited)
	Events.shop_exited.connect(_change_view.bind(MAP_SCENE))
	Events.treasure_room_exited.connect(_change_view.bind(MAP_SCENE))
	
	map_button.pressed.connect(_change_view.bind(MAP_SCENE))
	buttle_button.pressed.connect(_change_view.bind(BATTLE_SCENE))
	treasure_button.pressed.connect(_change_view.bind(TREASURE_SCENE))
	rewards_button.pressed.connect(_change_view.bind(REWARDS_SCENE))
	shop_button.pressed.connect(_change_view.bind(SHOP_SCENE))
	campfire_button.pressed.connect(_change_view.bind(CAMPFIRE_SCENE))

func _setup_top_bar() -> void:
	gold_ui.run_stats = stats
	deck_botten.card_pile = character.deck
	deck_view.card_pile = character.deck
	deck_botten.pressed.connect(deck_view.show_current_view.bind("现牌堆"))
	

##更换当前场景树最低层场景（更换当前场景）
func  _change_view(scene:PackedScene) -> void:
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()
	
	get_tree().paused = false
	
	var new_view:= scene.instantiate()
	current_view.add_child(new_view)


func _on_map_exited() -> void:
	print("TODO：从地图改变视角")
