class_name DamageEffect
extends Effect

var amount: int = 0

func execute(targets:Array[Node]) -> void:
	for target in targets:
		
		if not target: #安全检查
			continue
			
		if target is Enemy or Player:
			target.take_damage(amount)
			SFXPlayer.play(sound)
