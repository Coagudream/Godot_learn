class_name Player
extends Node2D

const WHITE_SPRITE_MATERIAL = preload("res://art/white_sprite_material.tres")

@export var stats:CharacterStats :
	set(v):
		stats = v
		if not stats.stats_changed.is_connected(updata_stats):
			stats.stats_changed.connect(updata_stats)
			
		updata_player()

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var stars_ui: HBoxContainer = $starsUI



func updata_player() ->void:
	#卫语句
	if not stats is CharacterStats:
		return
	
	#编辑器运行时，@export会被调用，可能使该函数在节点进入场景树之前被调用（安全检查）
	if not is_inside_tree():
		await ready
	
	sprite_2d.texture = stats.art
	updata_stats()


func updata_stats() -> void :
	stars_ui.updata_stats(stats)


func take_damage(damage:int) -> void:
	if stats.health <= 0:
		return
		
	sprite_2d.material = WHITE_SPRITE_MATERIAL
	var tween:Tween = create_tween()
	tween.tween_callback(Shaker.sharker.bind(self,16,0.15))
	tween.tween_callback(stats.take_damage.bind(damage))
	tween.tween_interval(0.17)
	tween.finished.connect(
		func():
		sprite_2d.material = null
		if stats.health <= 0:
			Events.player_died.emit()
			queue_free()
		)
