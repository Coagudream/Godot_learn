class_name EnemyActionPicker
extends Node

@onready var total_weight := 0.0

@export var enemy:Enemy:
	set(v):
		enemy = v
		
		for action:EnemyAction in get_children():
			action.enemy = enemy

@export var target:Node2D:
	set(v):
		target = v
		
		for action:EnemyAction in get_children():
			action.target = target


func _ready() -> void:
	target = get_tree().get_first_node_in_group("player")
	setup_changes()



##逻辑--获取行动（优先获取条件性行动）
func get_action() -> EnemyAction:
	var action := get_first_coonditional_action()
	
	if action:
		return action
	
	return get_changce_based_action()

##获取第一个条件性行动
func get_first_coonditional_action() -> EnemyAction:
	var action : EnemyAction
	
	for child:EnemyAction in get_children():
		action = child
		if (not action is EnemyAction) or action.type != EnemyAction.Type.CONDITIONAL:
			continue
		
		if action.is_performable():
			return action
	
	return null

##获取概率性行动
func get_changce_based_action() -> EnemyAction:
	var action : EnemyAction
	var roll := randf_range(0.0,total_weight)
	
	for child in get_children():
		action = child
		
		if not action or action.type != EnemyAction.Type.CHANCE_BASED:
			continue
		if action.accumulated_weight > roll:
			return action
	return null

##设置权重
func setup_changes() -> void:
	var action : EnemyAction
	for child in get_children():
		action = child
		
		if not action or action.type != EnemyAction.Type.CHANCE_BASED:
			continue
		
		total_weight  += action.chang_weight
		action.accumulated_weight = total_weight
