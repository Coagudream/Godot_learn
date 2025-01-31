class_name ManaUI
extends Panel


@onready var mana_label: Label = $ManaLabel


@export var char_stats:CharacterStats:
	set(v):
		char_stats = v
		
		if not char_stats.stats_changed.is_connected(_on_stats_changed):
			char_stats.stats_changed.connect(_on_stats_changed)
		
		if not is_node_ready():
			await ready
		
		_on_stats_changed()

##更新法力值ui显示
func _on_stats_changed() -> void:
	mana_label.text = "%s/%s" % [char_stats.mana,char_stats.max_mana]
