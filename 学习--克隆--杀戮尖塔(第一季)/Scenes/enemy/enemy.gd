class_name Enemy
extends Area2D

##箭头偏移常量
const ARROW_OFFSET :int = 5

const WHITE_SPRITE_MATERIAL = preload("res://art/white_sprite_material.tres")
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var arrow: Sprite2D = $Arrow
@onready var stars_ui: HBoxContainer = $CollisionShape2D/starsUI
@onready var intent: HBoxContainer = $Intent


@export var stats:EnemyStats :
	set(v):
		stats = v.create_instance()
		if not stats.stats_changed.is_connected(updata_stats):
			stats.stats_changed.connect(updata_stats)
			stats.stats_changed.connect(updata_action)
		
		updata_enemy()


var enemy_action_picker:EnemyActionPicker
var current_action: EnemyAction:
	set(v):
		current_action = v
		if current_action:
			intent.updata_intent(current_action.intent)
		


##添加ai管理
func setup_ai() -> void:
	if enemy_action_picker:
		enemy_action_picker.queue_free()
	
	var new_action_picker:EnemyActionPicker = stats.ai.instantiate()
	add_child(new_action_picker)
	enemy_action_picker = new_action_picker
	enemy_action_picker.enemy = self


##根据现在敌人状态变化来改变当前的行动（条件性行动）
func updata_action() -> void:
	if not enemy_action_picker:
		return
	
	if not current_action:
		current_action = enemy_action_picker.get_action()
		return
	
	var new_conditional_action := enemy_action_picker.get_first_coonditional_action()
	if new_conditional_action and current_action != new_conditional_action:
		current_action = new_conditional_action
		
##ui更新
func updata_stats() -> void:
	stars_ui.updata_stats(stats)

##敌人初始化
func updata_enemy() -> void:
	if not stats is Stats:
		return
	
	if not is_inside_tree():
		await ready
		
	sprite_2d.texture = stats.art
	arrow.position = Vector2.RIGHT * (sprite_2d.get_rect().size.x/2 + ARROW_OFFSET)
	setup_ai()
	updata_stats()

##回合管理
func do_turn() -> void:
	stats.block = 0
	
	if not current_action:
		return
	
	current_action.perform_action()


##敌人受伤逻辑+生命检查
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
			queue_free()
		)


##箭头显示
func _on_area_entered(_area: Area2D) -> void:
	arrow.show()

##箭头隐藏
func _on_area_exited(_area: Area2D) -> void:
	arrow.hide()
