extends ColorRect

enum Anim {
	None,
	FadeIn,
	FadeOut
}

var anim = Anim.None
var time = 0.0

const ANIM_LENGTH = 0.4

@onready var description = $Description

func fade_in(text: String):
	anim = Anim.FadeIn
	time = ANIM_LENGTH
	description.text = text

func _process(delta):
	if time > 0.0:
		time -= delta
		var t = 1.0 - (time / ANIM_LENGTH)
		t = clamp(t, 0.0, 1.0)
		
		match anim:
			Anim.None:
				pass
			Anim.FadeOut:
				modulate.a = 1.0 - t
				if modulate.a < 0.03:
					hide()
			Anim.FadeIn:
				modulate.a = t
				if modulate.a > 0.03:
					show()
				description.visible_ratio = t
			_:
				pass
				
		if time <= 0.0:
			anim = Anim.None
