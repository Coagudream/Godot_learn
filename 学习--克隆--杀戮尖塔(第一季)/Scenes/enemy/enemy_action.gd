class_name EnemyAction
extends Node

enum Type{CONDITIONAL,CHANCE_BASED}

@onready var accumulated_weight := 0.0

@export var intent:Intent
@export var type: Type
@export_range(0.0,10.0) var chang_weight := 0.0
@export var sound :AudioStream

var enemy:Enemy
var target:Node2D

##判断是否是基于条件动作（默认false）
func is_performable() -> bool:
	return false


##基类方法
func perform_action() -> void:
	pass
