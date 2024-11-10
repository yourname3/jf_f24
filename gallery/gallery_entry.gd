extends TextureRect

@export var title: String = "consistency"
@export_multiline var description: String = ""

enum Anim {
	None,
	MoveToExamine,
	MoveBack,
	FadeOut,
	FadeIn
}

var anim = Anim.None
var time = 0.0

const ANIM_LENGTH = 0.3

@onready var gallery_target = %GalleryTargetPos
@onready var current_position = position

func do_anim(new_anim: Anim):
	anim = new_anim
	time = ANIM_LENGTH

func _on_examine_pressed():
	do_anim(Anim.MoveToExamine)
	
	for node in get_tree().get_nodes_in_group("GalleryEntry"):
		if node != self:
			node.do_anim(Anim.FadeOut)
			
	%GalleryDisplay.fade_in(description)

func _on_play_pressed():
	pass # Replace with function body.

func _on_back_pressed():
	pass # Replace with function body.

func _process(delta):
	if time > 0.0:
		time -= delta
		var t = 1.0 - (time / ANIM_LENGTH)
		t = clamp(t, 0.0, 1.0)
		
		match anim:
			Anim.None:
				pass
			Anim.MoveToExamine:
				position = current_position.lerp(gallery_target.position, t)
			Anim.FadeOut:
				modulate.a = 1.0 - t
				if modulate.a < 0.03:
					hide()
			_:
				pass
				
		if time <= 0.0:
			anim = Anim.None
