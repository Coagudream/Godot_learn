#CardUI类就是像一个壳子，定义好卡牌逻辑逻辑
class_name CardUI ##添加类名，静态类型（调用的时候被调用可以指定静态类型/添加代码注释）
extends Control ##继承自Control类，可以使用Control类的一切的所有方法/变量（属性）/信号

signal reparent_requested(which_card_ui:CardUI) ##定义了一个重新父化信号

#三个常量---更换主题样式实现更好的视觉效果（基础/鼠标悬停/鼠标点击）
const CARD_BASE_STYLEBOX = preload("res://Scenes/card_ui/card_base_stylebox.tres")
const CARD_DRAGGING_STYLEBOX = preload("res://Scenes/card_ui/card_dragging_stylebox.tres")
const CARD_HOVER_STYLEBOX = preload("res://Scenes/card_ui/card_hover_stylebox.tres")


@onready var card_visuals: CardVisuals = $CardVisuals
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var card_state_machine: CardStateMachine = $CardStateMachine
@onready var targets: Array[Node] = []  ##目标数组


var original_index:= 0
##卡牌的数据（灵魂）
@export var card : Card: 
	set(v):#每一次给变量赋新值时调用
		#因为后面要调用card变量的数据，等待子节点完全初始化后再填充数据
		if not is_node_ready():
			await ready
		
		card = v
		card_visuals.card = card

##玩家的数据
@export var char_stats:CharacterStats: 
	set(v):
		char_stats = v
		char_stats.stats_changed.connect(_on_char_stats_changed) #链接数据改变信号

var parent: Control
var tween: Tween

##基于法力值是否可以打出牌
var playable: bool =true:
	set(v):
		playable = v
		if not playable:
			card_visuals.cost.add_theme_color_override("font_color",Color.RED)
			card_visuals.icon.modulate = Color(1,1,1,0.5)
		else :
			card_visuals.cost.remove_theme_color_override("font_color")
			card_visuals.icon.modulate = Color(1,1,1,1)

##当一张卡牌正在拖动时，是否可以打出牌
var disabled := false

##动画补间函数
func animate_to_position(new_position:Vector2 , duration:float) -> void:
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"global_position",new_position,duration)


##打出卡牌
func play() ->void:
	if not card: #安全检查
		return
	
	card.play(targets,char_stats)
	queue_free() #卡牌打出后删除


func _on_card_drag_or_aiming_started(used_card: CardUI) -> void:
	if used_card == self:
		return
		
	disabled = true

func _on_card_drag_or_aim_ended(used_card: CardUI) -> void:
	disabled = false
	self.playable = char_stats.can_play_card(card)

func _on_char_stats_changed() -> void:
	self.playable = char_stats.can_play_card(card)


func _ready() -> void:
	card_state_machine.init(self)
	Events.card_aim_started.connect(_on_card_drag_or_aiming_started)
	Events.card_aim_ended.connect(_on_card_drag_or_aim_ended)
	Events.card_drag_started.connect(_on_card_drag_or_aiming_started)
	Events.card_drag_ended.connect(_on_card_drag_or_aim_ended)



##自动调用的虚方法
func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)

##满足条件（gui输入事件）即调用的信号
func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)

##满足条件（鼠标进入Control）即调用的信号
func _on_mouse_entered() -> void :
	card_state_machine.on_mouse_entered()

##满足条件（鼠标退出Control）即调用的信号
func _on_mouse_exited() -> void :
	card_state_machine.on_mouse_exited()


##进入可以被识别的区域后加入目标数组
func _on_drop_point_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)


##退出可以被识别的区域后加入目标数组
func _on_drop_point_detector_area_exited(area: Area2D) -> void:
	targets.erase(area)
