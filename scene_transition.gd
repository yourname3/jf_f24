extends CanvasLayer

var target_scene: PackedScene = null

func change_to(scene: PackedScene):
	if target_scene != null:
		return
		
	target_scene = scene
	$AnimationPlayer.play("fadeout")
	
func _anim_change_scene():
	assert(target_scene != null)
	get_tree().change_scene_to_packed(target_scene)
	target_scene = null
	$AnimationPlayer.play("fadein")
