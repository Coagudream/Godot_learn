# mata-name
# meta-description
extends EnemyAction

func perform_action() -> void:
	if not enemy or not target:
		return
	
	var tween:Tween = create_tween().set_trans(Tween.TRANS_QUINT)
	var start := enemy.global_position
	var end := target.global_position + Vector2.RIGHT*32
	
	SFXPlayer.play(sound)
	
	Events.enemy_action_completed.emit(enemy)
