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

@onready var gallery_target = %GalleryTargetPos
@onready var current_position = position

func _on_examine_pressed():
	anim = Anim.MoveToExamine
	time = 1.0

func _on_play_pressed():
	pass # Replace with function body.

func _on_back_pressed():
	pass # Replace with function body.

func _process(delta):
	if time > 0.0:
		var t = 1.0 - time
		time -= delta
		match anim:
			Anim.None:
				pass
			Anim.MoveToExamine:
				position = current_position.lerp(gallery_target.position, t)
			_:
				pass
