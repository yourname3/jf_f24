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
@onready var home_left: float = offset_left
@onready var home_right: float = offset_right
@onready var home_top: float = offset_top
@onready var home_bottom: float = offset_bottom

func do_anim(new_anim: Anim):
	anim = new_anim
	time = ANIM_LENGTH

func _on_examine_pressed():
	do_anim(Anim.MoveToExamine)
	
	$Examine.hide()
	
	for node in get_tree().get_nodes_in_group("GalleryEntry"):
		if node != self:
			node.do_anim(Anim.FadeOut)
			
	%GalleryDisplay.fade_in(description)

func _on_play_pressed():
	pass # Replace with function body.

func _on_back_pressed():
	do_anim(Anim.MoveBack)
	
	$Play.hide()
	$Back.hide()
	
	for node in get_tree().get_nodes_in_group("GalleryEntry"):
		if node != self:
			node.do_anim(Anim.FadeIn)

	%GalleryDisplay.fade_out()

func _process(delta):
	if time > 0.0:
		time -= delta
		var t = 1.0 - (time / ANIM_LENGTH)
		t = clamp(t, 0.0, 1.0)
		
		match anim:
			Anim.None:
				pass
			Anim.MoveToExamine:
				offset_left = lerp(home_left, gallery_target.offset_left, t)
				offset_top = lerp(home_top, gallery_target.offset_top, t)
				offset_bottom = lerp(home_bottom, gallery_target.offset_bottom, t)
				offset_right = lerp(home_right, gallery_target.offset_right, t)
				#position = current_position.lerp(gallery_target.position, t)
			Anim.MoveBack:
				offset_left = lerp(gallery_target.offset_left, home_left, t)
				offset_top = lerp(gallery_target.offset_top, home_top, t)
				offset_bottom = lerp(gallery_target.offset_bottom, home_bottom, t)
				offset_right = lerp(gallery_target.offset_right, home_right, t)
				#position = gallery_target.position.lerp(current_position, t)
			Anim.FadeOut:
				modulate.a = 1.0 - t
				if modulate.a < 0.03:
					hide()
			Anim.FadeIn:
				modulate.a = t
				if modulate.a > 0.03:
					show()
			_:
				pass
				
		if time <= 0.0:
			# At the end of this anim, show the buttons.
			if anim == Anim.MoveToExamine:
				$Play.show()
				$Back.show()
			if anim == Anim.MoveBack:
				$Examine.show()

			anim = Anim.None
