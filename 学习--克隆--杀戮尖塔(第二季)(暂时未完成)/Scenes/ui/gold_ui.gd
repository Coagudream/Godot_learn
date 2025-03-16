class_name GoldUI
extends HBoxContainer



@export var run_stats: RunStats :
	set(v):
		run_stats = v
		#链接信号的函数只需要触发一次
		if not run_stats.gold_changed.is_connected(_update_gold):
			run_stats.gold_changed.connect(_update_gold)
			_update_gold()

@onready var label: Label = $Label


func _ready() -> void:
	label.text = "0"

func _update_gold() -> void:
	label.text = str(run_stats.gold)
