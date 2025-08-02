extends StatusEffect
class_name StatusEffectPassiveDamage

@export var rateInSeconds = 1.0
@export var amount :int= 1 


var t = 0.0

func onFrame(delta):
	t += delta
	if t > rateInSeconds:
		if is_instance_valid(healthComponent):
			healthComponent.damagePassive(amount,displayName.to_lower())
		t -= rateInSeconds
