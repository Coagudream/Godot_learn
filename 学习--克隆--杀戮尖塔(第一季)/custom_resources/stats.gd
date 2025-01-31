class_name Stats
extends Resource

##定义状态改变信号（通知UI更新）
signal stats_changed

@export var max_health:int = 1
@export var art :Texture

var health :int = 1:
	set(v):
		health = clampi(v,0,max_health)
		stats_changed.emit()

var block : int :
	set(v):
		block = clampi(v,0,999)
		stats_changed.emit()

##造成伤害函数
func take_damage(damage:int) -> void:
	if damage <= 0:
		return
	var initial_damage = damage
	
	damage = clampi(damage - block,0,damage)
	
	self.block = clampi(block - initial_damage, 0,block)
	
	self.health -= damage
	

##回血函数
func heal(amount:int) -> void:
	self.health += amount

##保证初始状态不发生改变（因为游戏每一次重开保证从从初始状态开始），返回资源副本
func create_instance() -> Resource:
	var instance: Stats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	return instance
